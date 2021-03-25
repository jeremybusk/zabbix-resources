#!/usr/bin/env bash
# Installs host agents and registers with appropriate service server
set -ex  # Use -ex for debugging
. /etc/os-release
# releasever=$(echo ${VERSION_ID} | awk -F. '{print $1}')  # Used for Redhat


if [ $# -ne 1 ]; then
  echo "Requires minion_id_prefix to be appended on hostname for salt minion id."
  echo "Usage: $0 <minion_id_prefix>"
  echo "Example: $0 myprojectname.app.dev"
  exit 1
fi


hostname=$(hostname)
host_fqdn=$(hostname -f)

# SumoLogic Vars
accessid=XXXXX
accesskey=XXXX

# Salt vars
minion_id_prefix="$1"
minion_id="$(hostname -s).$minion_id_prefix"
# minion_version="2018.3"  # 2018.3, 2019.2, latest
minion_version="latest"  # 2018.3, 2019.2, latest

# Zabbix vars
domain="example.com"
host_metadata_item="system.uname"
zabbix_version="5.0"
zabbix_release="1"
zabbix_agent_config_file="/etc/zabbix/zabbix_agent2.conf"
tmpdir=$(mktemp -d -t agents-install-XXXXXXXXXX)


# Setup vars depending on Operating System
if [[ "${ID}" =~ ^(rhel|centos)$ ]]; then
  os_base=redhat
  pkg_app=yum
  pkg_ext=rpm
  curl -O "https://repo.zabbix.com/zabbix/${zabbix_version}/${ID}/pool/main/z/zabbix-release/${pkg_filename}"
  sumo_download_url="https://collectors.au.sumologic.com/rest/download/rpm/64"
  VERSION_ID=$(echo ${VERSION_ID} | awk -F. '{print $1}')  # Used for Redhat/Centos 7 and older
  sudo ${pkg_app} install -y curl
elif [[ "${ID}" =~ ^(ubuntu|debian)$ ]]; then
  os_base=debian
  pkg_app=apt
  pkg_ext=deb
  sumo_download_url="https://collectors.au.sumologic.com/rest/download/deb/64"
  sudo ${pkg_app} update -y
  sudo ${pkg_app} install -y curl
  zabbix_pkg_filename="zabbix-release-${zabbix_version}-${zabbix_release}.el${VERSION_ID}.noarch.rpm"
  curl -O "https://repo.zabbix.com/zabbix/${zabbix_version}/rhel/${VERSION_ID}/x86_64/${zabbix_pkg_filename}"
else
  echo "OS ${ID} ${VERSION_ID} is not supported."
fi


function clean_up() {
  rm -rf "${tmpdir}"
}


function minion_prep() {
  echo "Setting up minion to connect to master."
  sudo test -f /etc/salt/minion.orig || sudo cp /etc/salt/minion /etc/salt/minion.orig
  curl -s  https://github.com/raw/repo/master/salt/master_sign.pub \
  | sudo tee /etc/salt/pki/minion/master_sign.pub
  curl -s https://github.com/raw/repo/master/salt/minion.conf \
  | sudo tee /etc/salt/minion.d/minion.conf
  echo "${minion_id}" | sudo tee /etc/salt/minion_id > /dev/null
}


function rhel_repo_add_eh() {
  # This adds custom example rhel repo for bootstraping before registeration/licensing
  VERSION_ID=$(echo ${VERSION_ID} | awk -F. '{print $1}')  # Used for Redhat/Centos 7 and older
  if [[ "${ID}" =~ ^(rhel)$ ]]; then
    curl -O "https://repo.example.com/${ID}/${VERSION_ID}/os/RPM-GPG-KEY-redhat-release" && rpm --import RPM-GPG-KEY-redhat-release
    echo "[customos]
name=Custom ${VERSION_ID} - OS
baseurl=https://repo.example.com/rhel/${VERSION_ID}/os/
enabled=1
gpgcheck=1" | sudo tee /etc/yum.repos.d/eh.repo
  fi
}


function salt_states_apply() {
  sudo salt-call state.sls ca.cert_pkgs
  sudo salt-call state.sls ca.cert
  sudo salt-call state.highstate
  sudo salt-call saltutil.refresh_pillar
  sudo salt-call mine.update
}


function sumo_uninstall() {
  sudo ${pkg_app} remove -y SumoCollector
}


function sumo_install() {
  curl -L ${sumo_download_url} -o sumologic64.${pkg_ext}
  sudo ${pkg_app} install -y ./sumologic64.${pkg_ext}
  echo -e "name=${hostname}\naccessid=${accessid}\naccesskey=${accesskey}" | sudo tee /opt/SumoCollector/config/user.properties
  sudo /opt/SumoCollector/collector install
  sudo /opt/SumoCollector/collector start
}


ubuntu_additional_prep() {
  # This was being used in past. Not sure if this is needed or not but we'll include.
  # ipddr=$(ip -o -4 addr | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\\.){3}[0-9]*).*/\\2/p')
  my_ip=$(ip route get 8.8.8.8 | awk '/8.8.8.8/ {print $NF}')
  vmname=$(hostname)
  sudo sed -i.bak "2i$my_ip $vmname" /etc/hosts
  sudo apt-get -y install virt-what
  if [ "$(echo "^$minion_id" | grep -c "legacy")" -ge 1 ]; then
    echo -e 'grains:\n  roles:\n    - legacy\n' | sudo tee /etc/salt/minion.d/grains.conf > /dev/null
  fi
}


function salt_install() {
  if [[ "${ID}" =~ ^(rhel|centos)$ ]]; then
    redhat_based_install_salt
  elif [[ "${ID}" =~ ^(ubuntu|debian)$ ]]; then
    debian_based_install_salt
  else
    echo "OS ${ID} ${VERSION_ID} is not supported."
  fi
}


function zabbix_install() {
  # address=/monitor-proxies-passive.example.com/10.x.x.x # zabbix proxy/server ip
  # address=/monitor-proxies-active.example.com/10.x.x.x # zabbix proxy/server ip
  #Agent Install, probably will work on Debian too
  # Make sure you have tcp 10051 open or fowarding to your Zabbix Server/Proxy
  # StartAgents=0 disables passive checks
  # cmd="wget https://repo.zabbix.com/zabbix/${zabbix_version}/${VERSION_CODENAME}/pool/main/z/zabbix-release/zabbix-release_${VERSION}-${RELEASE}+${VERSION_CODENAME}_all.deb"
  #https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1+focal_all.deb
  # cmd="curl -O https://repo.zabbix.com/zabbix/${zabbix_version}/${ID}/pool/main/z/zabbix-release/zabbix-release_${zabbix_version}-${zabbix_release}+${VERSION_CODENAME}_all.deb"
  passive_proxies_fqdn="monitor-proxies-passive.${domain}"
  active_proxies_fqdn="monitor-proxies-active.${domain}"
  if [[ "${ID}" =~ ^(rhel|centos)$ ]]; then
    zabbix_redhat_based_install
  elif [[ "${ID}" =~ ^(ubuntu|debian)$ ]]; then
    zabbix_debian_based_install
  else
    echo "OS ${ID} ${VERSION_ID} is not supported."
    return 1
  fi
  sudo sed -i "s/^Server=.*/Server=${passive_proxies_fqdn}/g" $zabbix_agent_config_file
  sudo sed -i "s/^ServerActive=.*/ServerActive=${active_proxies_fqdn}/g" $zabbix_agent_config_file
  sudo sed -i "s/^Hostname=.*/Hostname=${host_fqdn}/g" $zabbix_agent_config_file
  # sudo sed -i -E "s/^(# |)HostMetadataItem=.*/HostMetadataItem=system.uname/g" $zabbix_agent_config_file
  sudo sed -i -E "s/^(# |)HostMetadataItem=.*/HostMetadataItem=${host_metadata_item}/g" $zabbix_agent_config_file
  # sed -i -E "s/^(# |)StartAgents=.*/StartAgents=0/g" $ZABBIX_AGENT_CONFIG # disables passive agent listener
  sudo systemctl restart zabbix-agent2
  sudo systemctl enable zabbix-agent2
}


function zabbix_debian_based_install() {
  rm -f "${zabbix_pkg_filename}" || true
  curl -O "https://repo.zabbix.com/zabbix/${zabbix_version}/${ID}/pool/main/z/zabbix-release/${zabbix_pkg_filename}"
  sudo apt remove -y --purge zabbix-agent2 || true
  sudo dpkg -i ${pkg_filename}
  sudo ${pkg_app} update
  sudo ${pkg_app} install -y zabbix-agent2
}


function zabbix_redhat_based_install() {
  rm -f "${zabbix_pkg_filename}" || true
  curl -O "https://repo.zabbix.com/zabbix/${zabbix_version}/rhel/${VERSION_ID}/x86_64/${pkg_filename}"
  sudo yum remove -y zabbix-agent2
  sudo yum install -y ./${pkg_filename} || true
  sudo yum install -y zabbix-agent2
}


function salt_redhat_based_install() {
  rhel_repo_add_eh
  sudo yum remove -y salt-minion || true
  sudo yum install -y sudo
  sudo yum install -y "https://repo.saltstack.com/py3/redhat/salt-py3-repo-latest.el${VERSION_ID}.noarch.rpm"
  sudo yum install -y "https://repo.saltstack.com/py3/redhat/salt-py3-repo-${minion_version}.el${VERSION_ID}.noarch.rpm"
  sudo yum install -y salt-minion
  minion_prep
  sudo systemctl start salt-minion
  sudo systemctl enable salt-minion
}


function salt_debian_based_install() {
  sudo apt-get remove -y salt-minion || true
  curl "https://repo.saltstack.com/py3/${ID}/${VERSION_ID}/amd64/${minion_version}/SALTSTACK-GPG-KEY.pub" | sudo apt-key add -
  echo "deb http://repo.saltstack.com/py3/${ID}/${VERSION_ID}/amd64/${minion_version} ${VERSION_CODENAME} main" | sudo tee /etc/apt/sources.list.d/saltstack.list
  sudo apt-get update -y
  sudo apt-get install -y salt-minion || true
  minion_prep
  ubuntu_additional_prep
  sudo systemctl restart salt-minion
  sudo systemctl enable salt-minion  # It should already be enabled but JIC
  # sleep 15
  # salt_states_apply  # apply high state
}


function amp_install_redhat_based() {
  if [[ "${VERSION_ID}" == 8 ]]; then
    amp_url="https://console.amp.cisco.com/install_packages/<uuid>/download?product=LinuxProduct&product_variant_id=<uuid>"
  elif [[ "${VERSION_ID}" == 7 ]]; then
    amp_url="https://console.amp.cisco.com/install_packages/<uuid>/download?product=LinuxProduct&product_variant_id=<uuid>"
  else
    echo "OS VERSION_ID ${VERSION_ID} is not supported."
  fi
  curl -L "${amp_url}" -o amp.rpm
  yum install -y ./amp.rpm
  # sudo /opt/Tanium/TaniumClient/TaniumClient config set ServerNameList myserver.example.com
}


function tanium_install() {
  if [[ "${VERSION_ID}" == 8 ]]; then
    echo "OS VERSION_ID ${VERSION_ID} is not supported."
  elif [[ "${VERSION_ID}" == 7 ]]; then
    tanium_url="https://repo.example.com/downloads/7-tanium.tgz"
  else
    echo "OS VERSION_ID ${VERSION_ID} is not supported."
  curl -L "${tanium_url}" -o tanium.tgz
  tar -zxf tanium.tgz
  sudo yum install -y ./TaniumClient-7.2.314.3518-1.rhe7.x86_64.rpm
  sudo cp tanium.pub /opt/Tanium/TaniumClient/
  sudo /opt/Tanium/TaniumClient/TaniumClient config set ServerNameList myserver.example.com
  sudo /opt/Tanium/TaniumClient/TaniumClient config set LogVerbosityLevel 1
  sudo systemctl restart taniumclient
  echo "select * from app_config_config;" | sudo sqlite3 /opt/Tanium/TaniumClient/client.db
}


function main() {
  cd "${tmpdir}"
  if [[ ${os_base} == "redhat" ]]; then
    echo "Redhat"
  elif [[ ${os_base} == "debian" ]]; then
    echo "Debian"
  else
    echo "OS ${ID} ${VERSION_ID} is not supported."
    clean_up
    exit 1
  fi
  zabbix_install
  # salt_install
  # tanium_install
  # amp_install
  clean_up
}


# Notes
# You can use bootrapper instead of repos but we will use repos
# https://github.com/saltstack/salt-bootstrap/blob/develop/bootstrap-salt.sh
# curl -L https://bootstrap.saltstack.com -o install_salt.sh
# sudo sh install_salt.sh -P -M
