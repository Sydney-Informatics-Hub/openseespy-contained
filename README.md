# openseespy Container

Docker/Singularity image to run [openseespy]([https://github.com/ultralytics/ultralytics](https://openseespydoc.readthedocs.io/en/stable/index.html)) on Centos 6.10 kernel 


If you have used this work for a publication, you must acknowledge SIH, e.g: "The authors acknowledge the technical assistance provided by the Sydney Informatics Hub, a Core Research Facility of the University of Sydney."


# Quickstart for Artemis

Put this repo on Artemis e.g.

```
cd /project/<YOUR_PROJECT>
git clone https://github.com/Sydney-Informatics-Hub/openseespy-contained.git
```
Then `cd openseespy-contained` and modify the `run_artemis.pbs` script and launch with `qsub run_artemis.pbs`.

Otherwise here are the full instructions for getting there....


# How to recreate

## Build with docker
Check out this repo then build the Docker file.
```
sudo docker build . -t sydneyinformaticshub/openseespy
```

## Run with docker.
To run this, mounting your current host directory in the container directory, at /project, and execute a run on the test images (that live in the container) run:
```
wget https://openseespydoc.readthedocs.io/en/stable/_downloads/48b6b6a2312615c1c13cb54041ba5b0e/ElasticTruss.py
sudo docker run -it -v `pwd`:/project sydneyinformaticshub/openseespy /bin/bash -c "cd /project && python ElasticTruss.py"
```

## Push to docker hub
```
sudo docker push sydneyinformaticshub/openseespy
```

See the repo at [https://hub.docker.com/r/sydneyinformaticshub/openseespy](https://hub.docker.com/r/sydneyinformaticshub/openseespy)


## Build with singularity
```
export SINGULARITY_CACHEDIR=`pwd`
export SINGULARITY_TMPDIR=`pwd`

singularity build openseespy.img docker://sydneyinformaticshub/openseespy
```

## Run with singularity
To run the singularity image (noting singularity mounts the current folder by default)
```
wget https://openseespydoc.readthedocs.io/en/stable/_downloads/48b6b6a2312615c1c13cb54041ba5b0e/ElasticTruss.py
singularity run --bind /project:/project openseespy.img /bin/bash -c "cd "$PBS_O_WORKDIR" && python ElasticTruss.py"
```
