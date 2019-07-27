unset CONTAINER_NAME
# use local image
#CONTAINER_NAME="$(docker run -d -p 4000:80 python-test:v0.1.0 &)"

# use public container registry image
CONTAINER_NAME="$(docker run -d -p 4000:80 tcarecolin/tcc-python-server-test:v0.1.0 &)"
echo $CONTAINER_NAME > containerName
echo "started $CONTAINER_NAME"
exit 0