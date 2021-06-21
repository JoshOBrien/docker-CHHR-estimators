## A few of Dockerfiles and scripts on which this is based:
##  - https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/Dockerfile_geospatial_4.1.0
##  - https://github.com/rocker-org/rocker-versioned2/blob/master/scripts/install_geospatial.sh
##  - https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/Dockerfile_rstudio_4.1.0
##
## To pull this image from the GitHub Container Repo, just do:
##
##   sudo docker pull ghcr.io/joshobrien/docker-chhr-estimators


FROM rocker/geospatial:4.1.0

RUN apt-get update \
    && sudo apt-get install emacs -y \
    && sudo apt-get install tmux -y \
    ## && tmux new-session -t spatial -d \
    ## && tmux source-file .tmux.conf \
    ## For Rmpfr (needed by ctmm)
    && sudo apt-get install libmpfr-dev -y \
    ## Provision with spatial and other R packages
    && install2.r ggspatial data.table ctmm amt gdalUtilities drat \
    && echo 'drat::addRepo("JoshOBrien")' >> ${R_HOME}/etc/Rprofile.site \
    && install2.r spTools chhrTools BHSdataWinecup
    ## && r -e 'drat::addRepo("JoshOBrien"); install.packages("spTools"); install.packages("chhrTools"); install.packages("BHSdataWinecup")'

## Following rocker/rstudio, make launching RStudio server the default
EXPOSE 8787

CMD ["/init"]
