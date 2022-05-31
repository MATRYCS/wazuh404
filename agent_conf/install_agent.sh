if [  -z "$1" ]; 
	then
	echo "Please provide manager ip using -i"
	exit 1
fi

while getopts i: flag
do
	case "${flag}" in
		i) manager_ip=${OPTARG};;
	esac
done

echo "IP: $manager_ip";
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add -
echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
WAZUH_MANAGER="$manager_ip" apt-get install wazuh-agent=4.0.4-1
cp agent.conf /var/ossec/etc/shared/agent.conf
systemctl daemon-reload 
systemctl enable wazuh-agent
systemctl start wazuh-agent
