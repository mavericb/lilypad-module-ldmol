# Use an official PyTorch image as the base image
FROM pytorch/pytorch:1.9.0-cuda11.1-cudnn8-runtime

# Set working directory
WORKDIR /app

# Install system dependencies and build tools
RUN apt-get update && apt-get install -y \
    git \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install or update Mambaforge
RUN wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh && \
    if [ -d "/opt/conda" ]; then \
        bash Mambaforge-Linux-x86_64.sh -b -u -p /opt/conda; \
    else \
        bash Mambaforge-Linux-x86_64.sh -b -p /opt/conda; \
    fi && \
    rm Mambaforge-Linux-x86_64.sh

# Add Conda to PATH
ENV PATH="/opt/conda/bin:${PATH}"

# Initialize conda for shell interaction
RUN conda init bash && \
    echo "conda activate ldmol" >> ~/.bashrc

# Clone the LDMol repository
RUN git clone https://github.com/amelie-iska/ldmol.git

# Change to the ldmol directory
WORKDIR /app/ldmol

# Create the Mamba environment
RUN mamba env create -f requirements.yaml

# Install gdown in the ldmol environment
RUN mamba run -n ldmol pip install gdown

# Download pretrained models
RUN mamba run -n ldmol gdown --folder https://drive.google.com/drive/folders/170znWA5u3nC7S1mzF7RPNP5faAn56Q45 && \
    mv /app/ldmol/LDMol/Pretrain /app/ldmol/ && \
    mv /app/ldmol/LDMol/data /app/ldmol/ && \
    rm -rf /app/ldmol/LDMol

# Set the entry point
ENTRYPOINT ["/bin/bash", "-c", "source ~/.bashrc && exec python inference_demo.py --num-samples 100 --ckpt ./Pretrain/checkpoint_ldmol.pt --prompt=\"$PROMPT\" --cfg-scale=5"]