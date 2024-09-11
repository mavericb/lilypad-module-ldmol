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

# Run the LDMol inference script
python3 /app/inference_demo.py --num-samples ${NUM_SAMPLES:-100} \
                               --ckpt ${CKPT_PATH:-./Pretrain/checkpoint_ldmol.pt} \
                               --prompt "${PROMPT:-This molecule includes benzoyl group.}" \
                               --cfg-scale ${CFG_SCALE:-5}