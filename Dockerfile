FROM bioconductor/bioconductor_docker:RELEASE_3_18-R-4.3.3

# Configure environment
ENV DOCKER_IMAGE_NAME='flowcyto-lylab'
ENV VERSION='2025-01-31' 

# Install R packages
ADD install_r_packages.R /
RUN /usr/local/bin/Rscript /install_r_packages.R