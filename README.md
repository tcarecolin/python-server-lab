# python-server-test
a dockerized python+redis simple server ready playground

Use a local Build :

```

docker run -d -p 4000:80 python-test:v0.1.0 &

```

Use a public container registry:
dockerHub url : https://cloud.docker.com/repository/registry-1.docker.io/tcarecolin/tcc-python-server-test
```

docker run -d -p 4000:80 tcarecolin/tcc-python-server-test:v0.1.0 &


```

Or simply use shell command to start/stop the server :

start :
```

sh startServer.sh

```
stop:
```

sh stopServer.sh

```

