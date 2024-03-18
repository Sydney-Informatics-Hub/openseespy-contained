# Container for running inference of

#To build this file:
#sudo docker build . -t sydneyinformaticshub/openseespy

#To run this, mounting your current host directory in the container directory,
# at /project, and excute an example run:
#sudo docker run -it -v `pwd`:/project sydneyinformaticshub/openseespy /bin/bash -c "cd /project && python ElasticTruss.py"

#To push to docker hub:
#sudo docker push sydneyinformaticshub/openseespy

#To build a singularity container
#export SINGULARITY_CACHEDIR=`pwd`
#export SINGULARITY_TMPDIR=`pwd`
#singularity build openseespy.img docker://sydneyinformaticshub/openseespy

#To run the singularity image (noting singularity mounts the current folder by default)
#singularity run --bind /project:/project openseespy.img /bin/bash -c "cd "$PBS_O_WORKDIR" && python ElasticTruss.py"

# Pull base image.
FROM ubuntu:16.04
MAINTAINER Nathaniel Butterworth USYD SIH

RUN mkdir /scratch /project

RUN apt-get update -y && \
	apt-get install git curl build-essential libsm6 libxext6 libxrender-dev libgl1 libfreetype6-dev -y && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /build

RUN curl -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-py38_4.8.2-Linux-x86_64.sh &&\
	mkdir /build/.conda && \
	bash miniconda.sh -b -p /build/miniconda3 &&\
	rm -rf /miniconda.sh

# RUN curl -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh &&\
# 		mkdir /build/.conda && \
# 		bash miniconda.sh -b -p /build/miniconda3 &&\
# 		rm -rf /miniconda.sh

ENV PATH="/build/miniconda3/bin:${PATH}"
ARG PATH="/build/miniconda3/bin:${PATH}"
RUN conda install pip
RUN pip install --upgrade pip

RUN pip install -U openseespy==0.5.10 && \
pip install matplotlib==3.7.5 && \
pip cache purge

CMD /bin/bash
