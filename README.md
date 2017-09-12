# nightwatch_docker

A holding repo for a nightwatch image inside a docker container

## Custom Globals file

The container has a globals.js file in it already to help stop you from having to set your globals.js file to meet the needs of the container. This however does stop you from having a globlas.js file though. To mitigate this the container will look for a customGlobals.js file that it will merge in to the globals.js file.
Therefore everything you need to put in globals.js, put it in a file called customGlobals.js and mount it in the container to the root directory like so:

```shell
-v /vagrant/nightwatch_docker_tests/customGlobals.js:/root/nightwatch/customGlobals.js
```

## Using the container

The container is designed to be easy to use and stops you from having to install anything to get running. It will only support chrome tests in headless mode. You will need to mount your folders with tests into /root/nightwatch. Below is an example of a test run with the folders mounted. If you want to add tags you need to called the startup.sh script in root. This is due to making the contianer very easy to get into for trouble shooting your tests. If you needed to just get into the container to have a poke about you can just call /bin/bash on the run statement. If you don't know what that means I would encourage you to learn a bit more about docker before proceeding with poking about in the container.

```shell
docker run \
    -it \
    --add-host=custom.domain.net:$IP \
    --env TEST_ADMIN_USERNAME="${JENKINS_USERNAME}" \
    --env TEST_ADMIN_PASSWORD="${JENKINS_WEB_PASSWORD}" \
    --env TEST_AGENT_USERNAME="${JENKINS_WEB_AGENT_USERNAME}" \
    --env TEST_AGENT_PASSWORD="${JENKINS_WEB_AGENT_PASSWORD}" \
    --env TEST_VERSION="${JENKINS_WEB_VERSION}" \
    -v /vagrant/tests:/root/nightwatch/tests \
    -v /vagrant/reports:/root/nightwatch/reports \
    -v /vagrant/custom_commands:/root/nightwatch/custom_commands \
    -v /vagrant/page_objects:/root/nightwatch/page_objects \
    -v /vagrant/customGlobals.js:/root/nightwatch/customGlobals.js \
    morfien101/nightwatch "./startup.sh --tag crawl --tag web_version";
```