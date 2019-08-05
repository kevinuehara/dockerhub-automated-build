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
  echo "########################## $TRAVIS_REPO_SLUG:${}"
  echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
  docker tag ${TRAVIS_REPO_SLUG} ${tag}
  docker push $tag
fi
