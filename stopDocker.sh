CONTAINER_NAME="$(cat containerName)"
echo "Stop "$CONTAINER_NAME
"$(docker container stop $CONTAINER_NAME &)"
exit 0