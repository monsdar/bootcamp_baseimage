# bootcamp_baseimage
Docker image that could be used as a base for the bootcamp environment. This is the environment in which the bootcamp tutorial takes place. Create your own Dockerfile from this one and add the stuff you want to have available in the environment.

Sample:

```
FROM monsdar/bootcamp_baseimage

# some example directories for the tutorial
RUN mkdir a_directory another_directory
```

Then start the docker-browser-server with your environment and connect the frontend.
