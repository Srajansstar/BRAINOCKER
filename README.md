<h1 align="center">Matlab docker test</h1>

<p align="center">
  Test App that runs a Brainstorm MATLAB pipeline (import, resample, PSD, notch and band-pass filtering) on an MEG FIF file and exports an HTML report.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.933"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.933-blue.svg" alt="Run on brainlife.io"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-see_LICENSE-lightgrey.svg" alt="License"></a>
</p>

## At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Test App that runs a Brainstorm MATLAB pipeline (import, resample, PSD, notch and band-pass filtering) on an MEG FIF file and exports an HTML report.**

Registered as a MATLAB/Brainstorm container test. main calls a Brainstorm binary under /opt without a container, so it only works inside the author's BRAINOCKER image, and the README restricts reuse of the code.

| | |
|---|---|
| **Inputs** | `neuro/meg/fif` |
| **Outputs** | `report/html` |
| **Run it** | [doi.org/10.25663/brainlife.app.933](https://doi.org/10.25663/brainlife.app.933) |

#### Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `fif` | `neuro/meg/fif` | yes | MEG recording (FIF). |

#### Outputs

| Output | Datatype | Description |
|---|---|---|
| `report` | `report/html` | Brainstorm HTML report of the processing steps. |

<!-- brainlife-app:end -->

## Running the App

### On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.933](https://doi.org/10.25663/brainlife.app.933), choose `neuro/meg/fif` from your project and press **Execute**. The results are saved to your project as `report/html`.

### Locally

You need [`jq`](https://jqlang.github.io/jq/).

1. Clone this repository.
2. Create `config.json` with the paths to your inputs and the parameters:

   ```json
   {
       "fif": "/path/to/fif/fif",
       "channels": "/path/to/fif/channels",
       "headshape": "/path/to/fif/headshape",
       "coordsystem": "/path/to/fif/coordsystem",
       "calibration": "/path/to/fif/calibration",
       "crosstalk": "/path/to/fif/crosstalk",
       "destination": "/path/to/fif/destination",
       "events": "/path/to/fif/events",
       "events_json": "/path/to/fif/events_json"
   }
   ```

3. Run `./main`.

## Singularity Setup (Recommended for Brainlife and HPC)

Because Brainlife and High-Performance Computing (HPC) clusters run containers through Singularity/Apptainer, we provide a Singularity definition recipe (`Singularity.def`) that installs the MATLAB Runtime (MCR) and Brainstorm with correct environment paths and non-root execution permissions.

## Building the Container Natively

To build the Singularity image (`.sif`), run the following command on a Linux system or WSL with Singularity/Apptainer installed:
```bash
sudo singularity build brainocker.sif Singularity.def
```

## Docker Setup (Local WSL)

For local development on a personal computer using Docker, check the instructions in `INSTRUCTIONS.txt`.

## GUI Mode

Ensure you have an X-Server (like VcXsrv) running on Windows with access control disabled.
```bash
xhost +
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix nicomm77/neurodockernmm:v1
```

## Server Mode

```bash
docker run -it --rm \
  -v /path/to/your/script/folder:/mnt/path \
  nicomm77/neurodockernmm:v1 \
  /usr/local/MATLAB/MATLAB_Runtime/R2023a /mnt/path/nameofyourfile.m
```

## Citing

If you use this App, please cite it, the software it builds on and brainlife.io:

- Matlab docker test. brainlife.io App. [doi:10.25663/brainlife.app.933](https://doi.org/10.25663/brainlife.app.933)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. *Scientific Data* 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## Authors

Maintained by [@Srajansstar](https://github.com/Srajansstar).

## License

See [LICENSE](LICENSE).
