
############# setup aws instances ##################

ssh -i "dockerswarm.pem" ubuntu@ec2-3-21-234-115.us-east-2.compute.amazonaws.com
ssh -i "dockerswarm.pem" ubuntu@ec2-3-21-204-27.us-east-2.compute.amazonaws.com
ssh -i "dockerswarm.pem" ubuntu@ec2-3-21-228-239.us-east-2.compute.amazonaws.com
ssh -i "dockerswarm.pem" ubuntu@ec2-3-21-227-50.us-east-2.compute.amazonaws.com
ssh -i "dockerswarm.pem" ubuntu@ec2-13-58-200-197.us-east-2.compute.amazonaws.com
ssh -i "dockerswarm.pem" ubuntu@ec2-18-223-155-176.us-east-2.compute.amazonaws.com

############## setup docker #######

sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" 
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

############## scp to ec2 ###############

scp -i "dockerswarm.pem" setupdocker.sh  ubuntu@ec2-3-21-227-50.us-east-2.compute.amazonaws.com:/home/ubuntu

############# setup docker swarm ##############

### MASTER ####
sudo docker swarm init --advertise-addr 172.31.30.37 
### WORKER ####
sudo docker swarm join --token SWMTKN-1-4id94k6hsz2hsd10ew5jdy6pe51joa68c2qjcwob39zyddn37m-92q2syn2lhkr42ct74xablke8 172.31.30.37:2377

############ pssh #################

pssh -h awsnodes.lst -x "-o StrictHostKeyChecking=no -i /home/nannan/dockerswarm.pem" -l ubuntu -i 'df -h'

########### docker stack ##########

docker stack deploy --compose-file docker-compose.yml socialnetwork

docker stack rm socialnetwork

docker ps socialnetwork

docker stack ls

sudo docker stack services socialnetwork

docker service ls

#--format "{{.Name}}: {{.Image}}"

sudo docker stack ps --format "{{.Name}}: {{.ID}}: {{.Error}}: {{.Ports}}" socialnetwork

