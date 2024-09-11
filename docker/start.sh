#!/bin/bash

echo "LDMol container started"

if [[ $PUBLIC_KEY ]]
then
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    cd ~/.ssh
    echo $PUBLIC_KEY >> authorized_keys
    chmod 700 -R ~/.ssh
    cd /
    service ssh start
fi

# Activate Mamba environment
source /opt/conda/etc/profile.d/conda.sh
conda activate ldmol

# Run inference_demo.py
python /app/ldmol/inference_demo.py --num-samples 100 --ckpt ./Pretrain/checkpoint_ldmol.pt --prompt="$PROMPT" --cfg-scale=5