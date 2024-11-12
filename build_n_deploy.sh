TAG=mach12/tmp:frontend
docker login &&
  docker buildx build \
    --platform linux/amd64 \
    --tag $TAG . &&
  docker push $TAG
