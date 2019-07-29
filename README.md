# python-server-test
a dockerized python+redis simple server ready playground

## Single instance application Run

Use a local Build :

```

$ docker run -d -p 4000:80 python-server-test:v0.1.0 &

```

Use a public container registry:
dockerHub url : https://cloud.docker.com/repository/registry-1.docker.io/tcarecolin/tcc-python-server-test
```

$ docker run -d -p 4000:80 tcarecolin/tcc-python-server-test:v0.1.0 &


```

Or simply use shell command to start/stop the server :

start :
```

$ sh startServer.sh

```
stop:
```

$ sh stopServer.sh

```

View result :

```

$ curl http://localhost:4000

```

## Single host swarm deploy

Deploy a cluster of 10 containers using Swarm and Compose:

Note: replace localost by your physical network interface
```

$ docker swarm init --advertise-addr 127.0.0.1

```

Start the application
```

$ docker stack deploy -c docker-compose.yml my-lab

```

View running nodes :

```
$ docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE                                      PORTS
2jld7taiitjo        my-lab_web          replicated          10/10               tcarecolin/tcc-python-server-test:v0.1.0   *:4000->80/tcp

```
same as :

```
$ docker stack services my-lab
ID                  NAME                MODE                REPLICAS            IMAGE                                      PORTS
2jld7taiitjo        my-lab_web          replicated          10/10               tcarecolin/tcc-python-server-test:v0.1.0   *:4000->80/tcp

```


```
$ docker service ps my-lab_web
ID                  NAME                IMAGE                                      NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
6jck9q5s25l2        my-lab_web.1        tcarecolin/tcc-python-server-test:v0.1.0   P50                 Running             Running 3 minutes ago
os6gma8uul0k        my-lab_web.2        tcarecolin/tcc-python-server-test:v0.1.0   P50                 Running             Running 3 minutes ago
plzxpjkkbvff        my-lab_web.3        tcarecolin/tcc-python-server-test:v0.1.0   P50                 Running             Running 3 minutes ago
zwdn9p5h3d1u        my-lab_web.4        tcarecolin/tcc-python-server-test:v0.1.0   P50                 Running             Running 3 minutes ago
1n035cnskagm        my-lab_web.5        tcarecolin/tcc-python-server-test:v0.1.0   P50                 Running             Running 3 minutes ago
ictctie0gvs8        my-lab_web.6        tcarecolin/tcc-python-server-test:v0.1.0   P50                 Running             Running 3 minutes ago
ypfgrw8xitj1        my-lab_web.7        tcarecolin/tcc-python-server-test:v0.1.0   P50                 Running             Running 2 minutes ago
bcb391ph3hhk        my-lab_web.8        tcarecolin/tcc-python-server-test:v0.1.0   P50                 Running             Running 3 minutes ago
sih444caf4zl        my-lab_web.9        tcarecolin/tcc-python-server-test:v0.1.0   P50                 Running             Running 3 minutes ago
80vkuwyouckw        my-lab_web.10       tcarecolin/tcc-python-server-test:v0.1.0   P50                 Running             Running 3 minutes ago


```

List container names


```

$ docker container ls -q
1cc996736ae9
7212383437fa
1b5d8e88d34e
9582dc9b0d83
9d178114bb28
49215e1103ff
99c27420ece5
ccf92e03b74c
28f3a2ec6ab1
f99c83448b82

```

Exit the lab:

```

$ docker stack rm my_lab

```

```

$ docker swarm leave --force

```


## Multiple host cluster with swarm

in this experience i played with swarm to deploy a cluster on several physical machines at home with old used laptops.

Note: only 64bytes cpu architectures are suported (x86_64)

Note: docker daemon can be controled by either systemd or systemctl depending on the OS your host is running.

On each physical host, after a fresh install force daemon to startup a boot:
```
 $ sudo systemctl enable docker
 $ sudo systemctl start docker

```
### Troubleshoot Helper :
  Docker daemon logs:
  ```
  $ systemctl status docker
  ```

  daemon execution params:
  ```
  $ systemctl cat docker | grep ExecStart
  ```

  Docker service logs:
  ```
  $ journalctl -u docker
  ```
start the swarm on the master :
```

$ docker swarm init --advertise-addr <MANAGER_HOST_IP>
Swarm initialized: current node (jjaxo2cloezyvje1x24fkzxai) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-<SWARM_TOKEN> <MANAGER_HOST_IP>:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

```

On each worker execute the join command :
```
$ docker swarm join --token SWMTKN-1-<SWARM_TOKEN> <MANAGER_HOST_IP>:2377
```

Start the application :
```

$ docker stack deploy -c docker-compose.yml my-lab
```

see the joined nodes :
```

$ docker node ls
```

# Autmoatized swarm deploy
```
$ sh ./swarm.sh
```

