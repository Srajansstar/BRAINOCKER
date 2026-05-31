# License: NEURODOCK SOFTWARE LICENSE AGREEMENT
# For full terms, see the LICENSE file included in this repository.

# Usar una imagen base de Ubuntu
FROM ubuntu:20.04

# Instalar dependencias críticas (añadimos grep para procesar la descarga de Google Drive)
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    grep \
    libxt6 \
    libxmu6 \
    libglu1-mesa \
    libxrandr2 \
    libxcursor1 \
    libxi6 \
    libglib2.0-0 \
    libsm6 \
    xvfb \
    openjdk-11-jre-headless \
    libxaw7 \
    libxrender1 \
    libxtst6 \
    libxfixes3 \
    libgtk2.0-0 \
    libxext6 \
    libxinerama1 \
    libgl1-mesa-glx \
    x11-apps && \
    rm -rf /var/lib/apt/lists/*

# Descargar e instalar Matlab Runtime (MCR) en una ruta específica
WORKDIR /tmp
RUN wget -q -O matlab_runtime.zip "https://ssd.mathworks.com/supportfiles/downloads/R2023a/Release/8/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2023a_Update_8_glnxa64.zip" && \
    unzip -q matlab_runtime.zip && \
    ./install -mode silent -agreeToLicense yes -destinationFolder /opt/matlab_runtime/R2023a && \
    rm -rf /tmp/*

# Descargar e instalar Brainstorm desde tu enlace de Google Drive
RUN mkdir -p /opt/brainstorm /tmp/extracted && \
    wget --no-check-certificate "https://drive.usercontent.google.com/download?id=1_FhUKiMMUv_8kIMqVEaYtOSy7GawLd65&export=download&confirm=t" -O /tmp/brainstorm.zip && \
    unzip -q /tmp/brainstorm.zip -d /tmp/extracted && \
    if [ -d /tmp/extracted/brainstorm3 ]; then mv /tmp/extracted/brainstorm3/* /opt/brainstorm/; else mv /tmp/extracted/* /opt/brainstorm/; fi && \
    rm -rf /tmp/brainstorm.zip /tmp/extracted

# Configurar variables de entorno con la ruta correcta de MATLAB Runtime
ENV MATLABROOT=/opt/matlab_runtime/R2023a
ENV LD_LIBRARY_PATH=${MATLABROOT}/runtime/glnxa64:${MATLABROOT}/bin/glnxa64:${MATLABROOT}/sys/os/glnxa64
ENV XAPPLRESDIR=${MATLABROOT}/X11/app-defaults

RUN chmod +x /opt/brainstorm/bin/R2023a/brainstorm3.command

# Asegurar permisos de lectura y ejecución para cualquier usuario no-root (esencial para Singularity en Brainlife)
RUN chmod -R a+rX /opt/matlab_runtime /opt/brainstorm

# Configurar enlaces del enlazador dinámico
RUN ldconfig

# Pasar automáticamente la ruta de MCR al launcher para evitar el prompt interactivo que congela ejecuciones en la nube
ENTRYPOINT ["/opt/brainstorm/bin/R2023a/brainstorm3.command", "/opt/matlab_runtime/R2023a"]
