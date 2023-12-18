# Ultralytics YOLOv8 Container

Docker/Singularity image to run [YOLOv8](https://github.com/ultralytics/ultralytics) on Centos 6.9 kernel 


If you have used this work for a publication, you must acknowledge SIH, e.g: "The authors acknowledge the technical assistance provided by the Sydney Informatics Hub, a Core Research Facility of the University of Sydney."


# Quickstart for Artemis

Put this repo on Artemis e.g.

```
cd /project/<YOUR_PROJECT>
git clone https://github.com/Sydney-Informatics-Hub/yolov8-contained.git
```
Then `cd yolov8-contained` and modify the `run_artemis.pbs` script and launch with `qsub run_artemis.pbs`.

Otherwise here are the full instructions for getting there....


# How to recreate

## Build with docker
Check out this repo then build the Docker file.
```
sudo docker build . -t sydneyinformaticshub/ultralytics:yolov8
```

## Run with docker.
To run this, mounting your current host directory in the container directory, at /project, and execute a run on the test images (that live in the container) run:
```
sudo docker run -it -v `pwd`:/project sydneyinformaticshub/ultralytics:yolov8 /bin/bash -c "cd /project && python train.py"
```

## Push to docker hub
```
sudo docker push sydneyinformaticshub/ultralytics:yolov8
```

See the repo at [https://hub.docker.com/r/sydneyinformaticshub/ultralytics](https://hub.docker.com/r/sydneyinformaticshub/ultralytics)


## Build with singularity
```
export SINGULARITY_CACHEDIR=`pwd`
export SINGULARITY_TMPDIR=`pwd`

singularity build spaceranger.img docker://sydneyinformaticshub/ultralytics:yolov8
```

## Run with singularity
To run the singularity image (noting singularity mounts the current folder by default)
```
singularity run --bind /project:/project yolo.img /bin/bash -c "cd "$PBS_O_WORKDIR" && python train.py"
```
