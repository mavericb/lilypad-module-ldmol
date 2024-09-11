# Use an official Mamba image as the base image
FROM mambaorg/micromamba:1.5.3

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install system dependencies
USER root
RUN apt-get update && apt-get install -y \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*
USER micromamba

# Create the Mamba environment
RUN micromamba create -f requirements.yaml -n ldmol

# Activate the environment
ARG MAMBA_DOCKERFILE_ACTIVATE=1

# Install gdown
RUN pip install gdown

# Download pretrained models
RUN gdown --folder https://drive.google.com/drive/folders/170znWA5u3nC7S1mzF7RPNP5faAn56Q45
RUN mv /app/LDMol/Pretrain /app/Pretrain
RUN mv /app/LDMol/data /app/data
RUN rm -rf /app/LDMol

# Set the default command to run when the container starts
CMD ["micromamba", "run", "-n", "ldmol", "torchrun", "--nnodes=1", "--nproc_per_node=2", "inference_demo.py", "--num-samples", "100", "--ckpt", "./Pretrain/checkpoint_ldmol.pt", "--prompt", "This molecule includes benzoyl group.", "--cfg-scale", "5"]