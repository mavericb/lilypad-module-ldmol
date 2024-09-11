# Use NVIDIA CUDA base image
FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PATH="/opt/conda/bin:${PATH}"

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update -y && \
    apt-get install -y curl wget git libgl1-mesa-glx libglib2.0-0 openssh-server && \
    rm -rf /var/lib/apt/lists/*

# Install Mamba
RUN wget -qO- https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh | bash -s -- -b -p /opt/conda && \
    mamba init bash

# Clone the LDMol repository
RUN git clone https://github.com/amelie-iska/ldmol.git /app/ldmol

# Create Mamba environment and install dependencies
WORKDIR /app/ldmol
RUN mamba env create -f requirements.yaml && \
    mamba clean -afy

# Install gdown in the base environment
RUN mamba install -y -c conda-forge gdown

# Download pretrained models
RUN gdown --folder https://drive.google.com/drive/folders/170znWA5u3nC7S1mzF7RPNP5faAn56Q45 && \
    mv /app/ldmol/LDMol/Pretrain /app/ldmol/ && \
    mv /app/ldmol/LDMol/data /app/ldmol/ && \
    rm -rf /app/ldmol/LDMol

# Copy start script
COPY start.sh /app/start.sh

# Make start.sh executable
RUN chmod +x /app/start.sh

# Set the entrypoint
ENTRYPOINT ["/app/start.sh"]