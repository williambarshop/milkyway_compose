# milkyway_compose
Docker compose for MilkyWay.  This is intended for setup onto a simple cluster with BOTH a Linux and Windows host machine.

swarm startup script

ON LINUX TO MAKE HEAD NODE:


# Configuration of Docker Swarm (initial setup)
Note: This setup describes a simple scenario of ONE Linux machine (galaxy headnode) and ONE Windows Server (Pulsar node)
Both machines require Docker 1.13 or newer.

1. Run 'ifconfig' to get your headnode (linux box) IP address

[wbarshop@headnode milkyway_compose]$ ifconfig
docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 0.0.0.0
        inet6 fe80::42:ff:fee0:e21f  prefixlen 64  scopeid 0x20<link>
        ether 02:42:00:e0:e2:1f  txqueuelen 0  (Ethernet)
        RX packets 852461  bytes 48626430 (46.3 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 5638075  bytes 8389152513 (7.8 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.44.241.214  netmask 255.255.255.0  broadcast 10.44.241.255
        inet6 fe80::2329:6bbd:9ac6:d1d8  prefixlen 64  scopeid 0x20<link>
        ether 00:15:5d:f1:80:0d  txqueuelen 1000  (Ethernet)
        RX packets 53014210  bytes 60122224312 (55.9 GiB)
        RX errors 0  dropped 3115  overruns 0  frame 0
        TX packets 8171362  bytes 6372676527 (5.9 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1  (Local Loopback)
        RX packets 171212511  bytes 54638983317 (50.8 GiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 171212511  bytes 54638983317 (50.8 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

------------------------------------------------------------------------	
For example, here I would want '10.44.241.214'


2.  Open ports TCP 2377, TCP/UDP 7946 and UDP 4789 on the headnode and each node
You may need to open port 50 if you set your docker overlay network to be encrypted.

On our CentOS 7.x server, this can be done with the following commands:

sudo firewall-cmd --zone=public --add-port=2377/tcp --permanent
sudo firewall-cmd --zone=public --add-port=7946/tcp --permanent
sudo firewall-cmd --zone=public --add-port=7946/udp --permanent
sudo firewall-cmd --zone=public --add-port=4789/udp --permanent
sudo firewall-cmd --reload


On our Windows Server 2016 machine, we can do this in a powershell:
New-NetFirewallRule -DisplayName “Docker Swarm 2377” -Direction Inbound –Protocol TCP –LocalPort 2377 -Action allow
New-NetFirewallRule -DisplayName “Docker Swarm 7946 TCP” -Direction Inbound –Protocol TCP –LocalPort 7946 -Action allow
New-NetFirewallRule -DisplayName “Docker Swarm 7946 UDP” -Direction Inbound –Protocol UDP –LocalPort 7946 -Action allow
New-NetFirewallRule -DisplayName “Docker Swarm 4789 UDP” -Direction Inbound –Protocol UDP –LocalPort 4789 -Action allow

3.  Let's actually start up a swarm!

On the linux headnode, using the IP address from Step 1:

docker swarm init --advertise-addr 10.44.241.214

The output to this command should look like:

Swarm initialized: current node (dxn1zf6l61qsb1josjja83ngz) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join \
    --token SWMTKN-1-49nj1cmql0jkz5s954yi3oex3nedyz0fb0xx14ie39trti4wxv-8vxv8rssmk743ojnwacrr2e7c \
    10.44.241.214:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

Please copy the provided worker join command, in this case:
    
	docker swarm join \
    --token SWMTKN-1-49nj1cmql0jkz5s954yi3oex3nedyz0fb0xx14ie39trti4wxv-8vxv8rssmk743ojnwacrr2e7c \
    10.44.241.214:2377
	
	
4. Let's add our windows machine into the cluster.
In a powershell, let's go ahead and run that command above...

	docker swarm join \
    --token SWMTKN-1-49nj1cmql0jkz5s954yi3oex3nedyz0fb0xx14ie39trti4wxv-8vxv8rssmk743ojnwacrr2e7c \
    10.44.241.214:2377
	
	
Please run 

docker node ls

To ensure that you can see the two nodes.  If you can, then we can move on!

5. Let's deploy our stack to the swarm!  Run the following command on the headnode.

docker stack deploy --compose-file docker-stack.yml milkyway-stack

At this point, you should be able to check on the running stack by

docker stack ps
