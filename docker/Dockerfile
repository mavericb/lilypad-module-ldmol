# Use an official PyTorch image as the base image
FROM pytorch/pytorch:1.9.0-cuda11.1-cudnn8-runtime

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Check if Conda is installed, if not, install Mamba
RUN if ! command -v conda &> /dev/null; then \
        wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh && \
        bash Mambaforge-Linux-x86_64.sh -b -p /opt/conda && \
        rm Mambaforge-Linux-x86_64.sh; \
    elif [ ! -d "/opt/conda" ]; then \
        mkdir -p /opt/conda && \
        ln -s $(dirname $(which conda))/../ /opt/conda; \
    fi

# Add Conda to PATH if it's not already there
ENV PATH="/opt/conda/bin:${PATH}"

# Clone the LDMol repository
RUN git clone https://github.com/amelie-iska/ldmol.git

# Change to the ldmol directory
WORKDIR /app/ldmol

# Create and activate the Mamba environment
RUN conda env create -f requirements.yaml && \
    echo "conda activate ldmol" >> ~/.bashrc

# Install gdown
RUN pip install gdown

# Download pretrained models
RUN gdown --folder https://drive.google.com/drive/folders/170znWA5u3nC7S1mzF7RPNP5faAn56Q45 && \
    mv /app/ldmol/LDMol/Pretrain /app/ldmol/ && \
    mv /app/ldmol/LDMol/data /app/ldmol/ && \
    rm -rf /app/ldmol/LDMol

# Set the entry point
ENTRYPOINT ["/bin/bash", "-c", "conda activate ldmol && exec python inference_demo.py --num-samples 100 --ckpt ./Pretrain/checkpoint_ldmol.pt --prompt=\"$PROMPT\" --cfg-scale=5"]