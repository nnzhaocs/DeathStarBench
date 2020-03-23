
pssh -h awsnodes.lst -x "-o StrictHostKeyChecking=no -i /home/nannan/dockerswarm.pem" -l ubuntu -i 'sudo docker stop -f $(sudo docker ps -a -q)'

pssh -h awsnodes.lst -x "-o StrictHostKeyChecking=no -i /home/nannan/dockerswarm.pem" -l ubuntu -i 'sudo docker rmi -f $(sudo docker images -a -q)'

