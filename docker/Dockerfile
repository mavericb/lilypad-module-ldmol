# Use an official Conda image as the base image
FROM continuumio/miniconda3

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Mamba
RUN conda install mamba -n base -c conda-forge

# Create the Conda environment
RUN mamba env create -f requirements.yaml

# Make RUN commands use the new environment
SHELL ["conda", "run", "-n", "ldmol", "/bin/bash", "-c"]

# Install gdown
RUN pip install gdown

# Download pretrained models
RUN gdown --folder https://drive.google.com/drive/folders/170znWA5u3nC7S1mzF7RPNP5faAn56Q45
RUN mv /app/LDMol/Pretrain /app/Pretrain
RUN mv /app/LDMol/data /app/data
RUN rm -rf /app/LDMol

# Set the default command to run when the container starts
CMD ["conda", "run", "--no-capture-output", "-n", "ldmol", "torchrun", "--nnodes=1", "--nproc_per_node=2", "inference_demo.py", "--num-samples", "100", "--ckpt", "./Pretrain/checkpoint_ldmol.pt", "--prompt", "This molecule includes benzoyl group.", "--cfg-scale", "5"]