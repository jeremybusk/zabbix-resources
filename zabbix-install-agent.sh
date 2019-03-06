#!/usr/bin/env bash 
#Agent Install, probably will work on Debian too
# Make sure you have tcp 10051 open or fowarding to your Zabbix Server/Proxy
# StartAgents=0 disables passive checks
DOMAIN="example.com"
HostMetadataItem="system.uname"
VERSION="4.0"
RELEASE="2"
ZABBIX_AGENT_CONFIG="/etc/zabbix/zabbix_agentd.conf"
HOSTNAME=`hostname -f`
DISTRO=$(cat /etc/*release | grep '^ID=' | awk -F= '{print $2}')
echo $DISTRO

if [[ "${DISTRO}" == "debian" ]]; then
    CODENAME="stretch"
else
    CODENAME=$(cat /etc/*release | grep DISTRIB_CODENAME | awk -F= '{print $2}')
fi

apt remove -y --purge zabbix-agent
rm zabbix-release_${VERSION}-${RELEASE}+${CODENAME}_all.deb
cmd="wget http://repo.zabbix.com/zabbix/${VERSION}/${DISTRO}/pool/main/z/zabbix-release/zabbix-release_${VERSION}-${RELEASE}+${CODENAME}_all.deb"
echo $cmd
sleep 10
eval $cmd
sleep 10

PASSIVE_PROXIES_FQDN="monitor-proxies-passive.${DOMAIN}"
ACTIVE_PROXIES_FQDN="monitor-proxies-active.${DOMAIN}"
dpkg -i zabbix-release_${VERSION}-${RELEASE}+${CODENAME}_all.deb
apt update
apt install -y zabbix-agent
 
sed -i "s/^Server=.*/Server=${PASSIVE_PROXIES_FQDN}/g" $ZABBIX_AGENT_CONFIG
sed -i "s/^ServerActive=.*/ServerActive=${ACTIVE_PROXIES_FQDN}/g" $ZABBIX_AGENT_CONFIG
sed -i "s/^Hostname=.*/Hostname=${HOSTNAME}/g" $ZABBIX_AGENT_CONFIG
sed -i -E "s/^(# |)HostMetadataItem=.*/HostMetadataItem=system.uname/g" $ZABBIX_AGENT_CONFIG
# sed -i -E "s/^(# |)StartAgents=.*/StartAgents=0/g" $ZABBIX_AGENT_CONFIG # disables passive agent listener
systemctl restart zabbix-agent
systemctl enable zabbix-agent
