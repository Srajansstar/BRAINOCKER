# BRAINOCKER

Custom Docker and Singularity container to run Brainstorm in a MATLAB environment for Linux and HPC environments in a secure and reproducible manner.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

⚠️ **Usage Restrictions**
> This repository is published for academic and research purposes only.
> **Modification, redistribution, or reuse of all or part of the code is prohibited without prior authorization from the author.**
> For any exceptions or usage requests, please contact: `nicolascir.97@gmail.com`

---

## Singularity Setup (Recommended for Brainlife and HPC)

Because Brainlife and High-Performance Computing (HPC) clusters run containers through Singularity/Apptainer, we provide a Singularity definition recipe (`Singularity.def`) that installs the MATLAB Runtime (MCR) and Brainstorm with correct environment paths and non-root execution permissions.

### Building the Container Natively
To build the Singularity image (`.sif`), run the following command on a Linux system or WSL with Singularity/Apptainer installed:
```bash
sudo singularity build brainocker.sif Singularity.def
```

### Running in Singularity
You can execute MATLAB scripts (e.g. `PIPELINE_BRAINOCKER`) headlessly using the compiled image:
```bash
singularity run \
  --bind /path/to/your/script/folder:/mnt/scripts \
  --bind /path/to/your/data:/tmp/brainstorm_db \
  brainocker.sif /mnt/scripts/nameofyourfile.m
```

---

## Docker Setup (Local WSL)

For local development on a personal computer using Docker, check the instructions in `INSTRUCTIONS.txt`.

### GUI Mode
Ensure you have an X-Server (like VcXsrv) running on Windows with access control disabled.
```bash
xhost +
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix nicomm77/neurodockernmm:v1
```

### Server Mode
```bash
docker run -it --rm \
  -v /path/to/your/script/folder:/mnt/path \
  nicomm77/neurodockernmm:v1 \
  /usr/local/MATLAB/MATLAB_Runtime/R2023a /mnt/path/nameofyourfile.m
```
