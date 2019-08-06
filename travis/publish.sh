#!/bin/bash

echo "################# $TRAVIS_PULL_REQUEST"

if [ $TRAVIS_PULL_REQUEST == false ] ; then
  version="latest"
  if [ $TRAVIS_BRANCH != "master" ] ; then
    version=$TRAVIS_BRANCH
  fi

  DOCKER_TAG=$(echo ${version} | sed 's/\(.*\)\/\(.*\)/\1_\2/')

  tag=${TRAVIS_REPO_SLUG}:${DOCKER_TAG}

  echo "########################## $tag"
  echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
  docker tag ${TRAVIS_REPO_SLUG} ${tag}
  docker push $tag
  curl -X POST -H "Content-Type: application/json" --data '{}' https://cloud.docker.com/api/build/v1/source/3d351c62-2904-463c-82cf-d08327c4288f/trigger/269ab73b-5bdc-44e1-a223-1c8bd8a4d235/call/
fi
