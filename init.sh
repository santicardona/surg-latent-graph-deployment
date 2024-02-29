#!/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "Script directory: $SCRIPT_DIR"

# check if mmdetection exists
if [ -d "$SCRIPT_DIR/mmdetection" ]; then
  echo "mmdetection already exists. Skipping download."
else
    cd $SCRIPT_DIR && git clone https://github.com/open-mmlab/mmdetection.git
fi
export MMDETECTION=$SCRIPT_DIR/mmdetection

# check if SurgLatentGraph exists
if [ -d "$SCRIPT_DIR/SurgLatentGraph" ]; then
    echo "SurgLatentGraph already exists. Skipping download."
else
    cd $SCRIPT_DIR && git clone https://github.com/CAMMA-public/SurgLatentGraph.git
fi

# check if coco_init_wts exists
if [ -f "$SCRIPT_DIR/SurgLatentGraph/weights/coco_init_wts.zip" ]; then
    echo "coco_init_wts already exists. Skipping download."
else
    cd SurgLatentGraph/weights && wget -O coco_init_wts.zip https://seafile.unistra.fr/f/71eedc8ce9b44708ab01/?dl=1 && unzip coco_init_wts.zip
fi
export PYTHONPATH=$SCRIPT_DIR/SurgLatentGraph:$PYTHONPATH

find_in_conda_env(){
    conda env list | grep "${@}" >/dev/null 2>/dev/null
}

echo "Preparing environment"

if find_in_conda_env ".*latentgraph.*" ; then
    echo "Environment latentgraph already exists. Skipping creation."
   conda activate latentgraph
else 
    conda create -n latentgraph -y python=3.8 && conda activate latentgraph
fi

echo "Installing remaining dependencies"

conda install -y pytorch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 pytorch-cuda=11.8 -c pytorch -c nvidia \
&& conda install -y -c dglteam/label/cu113 dgl \
&& pip install torch-scatter -f https://data.pyg.org/whl/torch-2.1.0+cu118.html
&& pip install -U openmim \
&& mim install mmengine==0.7.4 \
&& mim install "mmcv==2.0.0rc1" \
&& mim install mmdet==3.2.0 \
&& pip install torchmetrics scikit-learn prettytable imagesize networkx opencv-python yapf==0.40.1

echo "Environment setup complete"

exit 0



