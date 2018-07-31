#!/bin/bash
# Ubuntu Agent Install, probably will work on Debian too
# Make sure you have tcp 10051 open or fowarding to your Zabbix Server/Proxy
# StartAgents=0 disables passive checks
DOMAIN="example.com"
HostMetadataItem="system.uname"
VERSION="3.4"
RELEASE="1"
ZABBIX_AGENT_CONFIG="/etc/zabbix/zabbix_agentd.conf"
HOSTNAME=`hostname`
CODENAME=$(cat /etc/*release | grep DISTRIB_CODENAME | awk -F= '{print $2}')
DISTRO=$(cat /etc/*release | grep '^ID=' | awk -F= '{print $2}')

rm zabbix-release_${VERSION}-${RELEASE}+${CODENAME}_all.deb
cmd="wget http://repo.zabbix.com/zabbix/${VERSION}/${DISTRO}/pool/main/z/zabbix-release/zabbix-release_${VERSION}-${RELEASE}+${CODENAME}_all.deb"
echo $cmd
eval $cmd

PASSIVE_PROXIES_FQDN="monitor-proxies-passive.${DOMAIN}"
ACTIVE_PROXIES_FQDN="monitor-proxies-active.${DOMAIN}"
dpkg -i zabbix-release_${VERSION}-${RELEASE}+${CODENAME}_all.deb
apt update
apt install -y zabbix-agent
 
sed -i "s/^Server=.*/Server=${PASSIVE_PROXIES_FQDN}/g" $ZABBIX_AGENT_CONFIG
sed -i "s/^ServerActive=.*/ServerActive=${ACTIVE_PROXIES_FQDN}/g" $ZABBIX_AGENT_CONFIG
sed -i "s/^Hostname=.*/Hostname=${HOSTNAME}/g" $ZABBIX_AGENT_CONFIG
sed -i -E "s/^(# |)HostMetadataItem=.*/HostMetadataItem=system.uname/g" $ZABBIX_AGENT_CONFIG
systemctl restart zabbix-agent
