
##############################################################################################################
Download and install Redis Stack (MacOS)
##############################################################################################################

## Overview of Redis Stack
https://redis.io/docs/stack/about/

## To sum up:
## Redis Stack was created to allow developers to build real-time 
##		applications with a backend data platform that can reliably 
##		process requests in milliseconds or less. 
##		Redis Stack does this by taking the original Redis OSS as the core 
##		and enhancing it with modern data models, data processing tools


## Install Redis Stack
https://redis.io/docs/stack/get-started/install/mac-os/


--------------- Start recording here


brew tap redis-stack/redis-stack

brew install redis-stack


# Start Redis Stack Server
## This is a separate instance from the Redis server we ran before
redis-stack-server


# Open up a new terminal tab 
# connect to this instance in a new terminal/shell
redis-cli


### in redis-cli ###
# List all the modules installed by redis-stack
module list


##############################################################################################################
Download and install Redis Stack (MacOS)
##############################################################################################################

https://redis.io/docs/stack/get-started/install/linux/


## Start with a NEW SEPARATE provisioned VM Instance on a cloud provider (e.g. GCP)
## The instance can be created with the following details:
name = redis-stack-vm-instance
machine type = e2 micro
region = asia-south1 (Mumbai)


------------------------------------ Start recording here

## Show the following in the recording

#-- Start on the VM instances page
#-- Click through and show the details of the VM created


## Assuming we start on the VM instances page with the instance up
## Click on SSH to bring up an SSH terminal

## IMPORTANT: Copy the URL of the SSH terminal and open up a new tab with 
## the SSH window (don't work on the small window that pops up by default)


# Install from the Redis Stack from the official packages.redis.io APT repository
# The repository currently supports Debian Bullseye (11), Ubuntu Xenial (16.04), Ubuntu Bionic (18.04), and Ubuntu Focal (20.04) on x86 processors.

# Add the repository to the apt index
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg

# Show the OS details
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list


## Update the package indexes
sudo apt-get update

## Download and install the latest version of Redis Stack Server
sudo apt-get install redis-stack-server


# Open up a new terminal tab 
# connect to this instance in a new terminal/shell
redis-cli


### in redis-cli ###
# List all the modules installed by redis-stack
module list




































