# Use NVIDIA CUDA base image
FROM nvidia/cuda:11.8.0-devel-ubuntu22.04 AS builder

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update -y && \
    apt-get install -y curl python3 python3-pip git libgl1-mesa-glx libglib2.0-0 && \
    rm -rf /var/lib/apt/lists/*

# Clone the LDMol repository
RUN git clone https://github.com/amelie-iska/ldmol.git .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.yaml

# Install gdown and download pretrained models
RUN pip3 install gdown && \
    gdown --folder https://drive.google.com/drive/folders/170znWA5u3nC7S7mzF7RPNP5faAn56Q45 && \
    mkdir -p Pretrain data && \
    mv LDMol/Pretrain/* Pretrain/ && \
    mv LDMol/data/* data/ && \
    rm -rf LDMol

# Copy additional files
COPY start.sh /app/start.sh

# Make start.sh executable
RUN chmod +x /app/start.sh

# Set the entrypoint
ENTRYPOINT ["/app/start.sh"]