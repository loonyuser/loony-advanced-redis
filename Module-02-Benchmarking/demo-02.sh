
##############################################################################################################
Benchmarking on remote host: GCP
##############################################################################################################
#######################################################
Setup VM
#######################################################

# Do this in a separate tab

# Open below webpage in webbrowse
http://ip4.me/
# note the ip address


# Start on the main Google dashboard page

# Create firewall rule 
Google cloud > VPC Networks > Firewall

Click on CREATE FIREWALL RULE
name = redis-access
target tags = redis-server
source ip range = 49.207.223.239/32 {use own IP address obtained from http://ip4.me/}
enable TCP
Ports = 6379
Click on CREATE

# Create VM India
Google cloud > Compute Engine > VM instances

Click on CREATE INSTANCE
name = redis-instance-india
machine type = e2 micro
region = asia-south1 (Mumbai)
Advanced option > Networking
network tags = redis-server
Click on CREATE

# Create VM USA
Google cloud > Compute Engine > VM instances

Click on CREATE INSTANCE
name = redis-instance-usa
machine type = e2 micro
Advanced option > Networking
network tags = redis-server
Click on CREATE

## IMPORTANT: Show that both VMs have been created on the main VM instances page

# Note external ip address of both VM
instance-india = 34.93.134.235
instance-usa = 34.134.203.33

# SSH and install redis (remember you will have to do this for each instance)

## IMPORTANT: Make sure you copy URL in the SSH window and paste it into a new tab 
## so the SSH window is actually in a new tab (do this for each VM)
## Set up one Redis and then the other one after the other
VM > SSH

## Update the package indexes
sudo apt-get update

## Download and install the latest version of Redis Server
sudo apt-get -y install redis-server


## Assuming the password is Hw4A8QZXhROXhD9uMFDcRG6ueVlTz/RYlVX+50rirJld3Yj3ZUmbBb89uNKTVLivya4U/8jZjXZ/Gkmx

## Edit the redis.conf file to make two changes 
sudo nano /etc/redis/redis.conf
# in NETWORK section replace "bind 124.0.0.1 ::1" with
bind 0.0.0.0

# in the SECURITY section replace "# requirepass foobared" with following 
# (We're using simple passwords to make our life simple)
requirepass redis-instance-india-password
# for usa = requirepass redis-instance-usa-password

# Save and exit redis.conf file
sudo service redis-server restart

## Check the Redis server process
ps -f -u redis

