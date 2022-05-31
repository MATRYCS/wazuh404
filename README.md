# WAZUH
Guide for installing through docker the following services:
+ Wazuh version 4.0.4 
+ Opendistro-for-elasticsearch:1.11.0 
+ wazuh-kibana-odfe:4.0.4_1.11.0

### Prerequisities
+ Heap size of 1g(fixed by docker yml file)

### Project Structure
+ `docker-compose.yml`: docker yml file for example installation of wazuh server and client
+ `confs`: directory for wazuh manager and agent configuration files:
  + `agent_conf`: configuration directory for wazuh agent
  + `server_conf`: configuration directory for wazuh server

### Installing a Wazuh Agent
1. Execute script `sudo ./agent_conf/install_agent.sh -i SERVER_IP` replace SERVER_IP with yours

### Installing Wazuh server
1. `Configure Firewall`: execute script `sudo ./server_conf/firewall_config.sh`
2.  Edit server_conf/ossec.conf:
    + In line 23 edit ip of host machine
    + In line 107 in `vulnerability detector` set `enabled` to `yes`
    + Choose appropriate provider and change `enabled` to `yes`
    + In line 148 in `provider name="nvd"` set `enabled` to `yes`
4. Copy the configuration files to volume ossec/etc
    + `cp server.conf/ossec.conf /var/lib/docker/volumes/wazuh404_ossec_etc/_data/ossec.conf`
5.  `sudo sysctl -w vm.max_map_count=262144`: Pass the maximum map count check(for linux only)
6.  `docker-compose up -d --build`: build project with all its dependencies through docker

### Run project locally
In order to run the Siem and Automatic Forensic Tool Interface 
+ `https://IP:443`
Where IP is the IP address of the host machine

### SOLVED BUGS
Increased heapsize to 1g IN yml file to avoid 429 transport error
+  `"ES_JAVA_OPTS=-Xms1g -Xmx1g"`