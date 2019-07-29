#!/bin/sh
# import env variables
. ./env
echo "Removing previous swarm..."
OLD_NODES=$(docker node ls -q)
echo $OLD_NODES
docker node rm --force $OLD_NODES
docker swarm leave --force
echo "Initializing new swarm..."
# does docker swarm init --advertise-addr $MASTER_IP
OUTPUT="$(docker swarm init --advertise-addr $MASTER_IP)"
SWARM_TOKEN=$(echo ${OUTPUT} |grep -o -P "(?<=token ).*(?=$MASTER_IP)")
echo "Swarm token : "$SWARM_TOKEN
# does docker swarm join --token SWMTKN-1-<SWARM_TOKEN> <MANAGER_HOST_IP>:2377
join_worker() {
  echo "Joining worker " $1
  ssh -p 22 $WORKERS_USER@$1 "echo $DOCKERHUB_PWD | docker login --username $DOCKERHUB_USER --password-stdin \
  && docker swarm leave \
  && docker swarm join --token $SWARM_TOKEN $MASTER_IP:2377"
}
# join all 3 workers
join_worker $WORKER_IP_1
join_worker $WORKER_IP_2
join_worker $WORKER_IP_3

docker stack deploy -c docker-compose.yml my_lab

docker node ls
exit 0