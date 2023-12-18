# Container for https://github.com/ultralytics/ultralytics
# This image has a max Cuda of 10.2 and python 3.8 as base.

#To build this file:
#sudo docker build . -t sydneyinformaticshub/ultralytics:yolov8

#To run this, mounting your current host directory in the container directory,
# at /project, and excute an example run:
#sudo docker run --gpus=all -it -v `pwd`:/project sydneyinformaticshub/ultralytics:yolov8 /bin/bash -c "cd /project && ipython test.py"

#To push to docker hub:
#sudo docker push sydneyinformaticshub/ultralytics:yolov8

#To build a singularity container
#export SINGULARITY_CACHEDIR=`pwd`
#export SINGULARITY_TMPDIR=`pwd`
#singularity build tf.img docker://sydneyinformaticshub/ultralytics:yolov8

#To run the singularity image (noting singularity mounts the current folder by default)
#singularity run --nv --bind /project:/project yolo.img /bin/bash -c "cd "$PBS_O_WORKDIR" && ipython test.py"

# Pull base image.
FROM nbutter/pytorch:ubuntu1604
MAINTAINER Nathaniel Butterworth USYD SIH

RUN touch /usr/bin/nvidia-smi

# Fix a few bugs by upgrading these libraries
RUN pip install -U ultralytics scikit-learn && \
  pip cache purge
