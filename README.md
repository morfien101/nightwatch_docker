# nightwatch_docker
A holding repo for a nightwatch image inside a docker container

# Custom Globals file
The container has a globals.js file in it already to help stop you from having to set your globals.js file to meet the needs of the container. This however does stop you from having a globlas.js file though. To mitigate this the container will look for a customGlobals.js file that it will merge in to the globals.js file.
Therefore everything you need to put in globals.js, put it in a file called customGlobals.js and mount it in the container to the root directory like so:

```
-v /vagrant/nightwatch_docker_tests/customGlobals.js:/root/nightwatch/customGlobals.js
```

#Using the container