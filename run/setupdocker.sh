
############## setup docker ##########


sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo apt-get install python-pip
sudo pip install pssh

sudo ln -s /usr/bin/parallel-ssh /usr/local/bin/pssh


