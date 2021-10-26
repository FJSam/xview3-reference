#!/bin/bash

set -e

sudo -u ec2-user -i <<'EOF'
unset SUDO_UID

WORKING_DIR=/home/ec2-user/SageMaker/custom-miniconda-2

# Create a custom conda environment
source "$WORKING_DIR/miniconda/bin/activate"
echo ". /home/ec2-user/SageMaker/custom-miniconda-2/etc/profile.d/conda.sh" >> ~/.bashrc

cd /home/ec2-user/SageMaker/v2/xview3-reference
echo "Creating xview3 conda environment"
conda env create -f environment_v2.yml

echo "Activating xview3 conda environment"
source "$WORKING_DIR/miniconda/bin/activate" xview3_v2

echo "Installing ipykernal and settng up jupyter kernel in background process."
pip install ipykernel
pip install --quiet boto3
pip install sagemaker
pip install efficientnet_pytorch
pip install tensorboardX
echo "Finished background installations"
EOF
