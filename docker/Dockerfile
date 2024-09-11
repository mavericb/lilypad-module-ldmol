# Usa un'immagine ufficiale Mambaforge come immagine base
FROM condaforge/mambaforge:latest

# Imposta la directory di lavoro nel container
WORKDIR /app

# Installa le dipendenze di sistema
RUN apt-get update && apt-get install -y git wget && rm -rf /var/lib/apt/lists/*

# Clona il repository
RUN git clone https://github.com/amelie-iska/ldmol.git .

# Crea l'ambiente mamba
RUN mamba env create -f requirements.yaml

# Attiva l'ambiente mamba e installa gdown
RUN mamba run -n ldmol pip install gdown

# Scarica i modelli pre-addestrati
RUN mamba run -n ldmol gdown --folder https://drive.google.com/drive/folders/170znWA5u3nC7S7mzF7RPNP5faAn56Q45 && \
    mkdir -p Pretrain data && \
    mv LDMol/Pretrain/* Pretrain/ && \
    mv LDMol/data/* data/ && \
    rm -rf LDMol

# Imposta il comando per eseguire lo script Python nell'ambiente mamba
CMD ["mamba", "run", "--no-capture-output", "-n", "ldmol", \
     "torchrun", "--nnodes=1", "--nproc_per_node=2", "inference_demo.py", \
     "--num-samples", "100", \
     "--ckpt", "./Pretrain/checkpoint_ldmol.pt", \
     "--prompt", "This molecule includes benzoyl group.", \
     "--cfg-scale", "5"]