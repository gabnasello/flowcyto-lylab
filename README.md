# Docker Image for Flowcytometry data analysis in RStudio 

# Build the docker images

From the project folder, run the command below:

```bash build.sh```

# Run docker container

## RStudio Server approach

From the project folder, run the command below:

```docker-compose up```

Which fires a RStudio Server.

## Alternative approach

From the project folder, run the command below:

```docker-compose up -d```

This command starts the container in the background. If you want to interact with it, you can attach to it using:

```docker exec -it flowcyto-lylab /bin/bash```