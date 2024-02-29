FROM continuumio/anaconda3:latest

# Installing packages for operating system
RUN apt update -y \
    && apt -y install build-essential \
    && apt -y install graphviz \
    && apt -y install ffmpeg libsm6 libxext6 \
    && apt -y install git \
    && apt -y install unzip

# Updating Anaconda packages
RUN conda update conda -y \
    && conda update --all -y \
    && python -m pip install --upgrade pip

WORKDIR /app
ENV WORKDIR="/app"

# See docs in https://github.com/CAMMA-public/SurgLatentGraph/
# clone mmdetection and export environment variable

COPY --chown=app:app mmdetection $WORKDIR/mmdetection
ENV MMDETECTION "$WORKDIR/mmdetection"

# clone SurgLatentGraph
COPY --chown=app:app SurgLatentGraph $WORKDIR/SurgLatentGraph

# add surglatentgraph to PYTHONPATH to enable registry to find custom modules (note that this can be added to the .bashrc file for future use)
ENV PYTHONPATH "$PYTHONPATH:$WORKDIR/SurgLatentGraph"

RUN conda create -n latentgraph python=3.8 -y
RUN echo "source activate latentgraph" > ~/.bashrc
ENV PATH /opt/conda/envs/latentgraph/bin:$PATH

RUN conda clean --all -y
RUN conda install pytorch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 pytorch-cuda=11.8 -c pytorch -c nvidia
RUN conda install -y -c dglteam/label/cu113 dgl
RUN pip install torch-scatter -f https://data.pyg.org/whl/torch-2.1.0+cu118.html
RUN pip install -U openmim
RUN mim install mmengine==0.7.4
RUN mim install "mmcv==2.0.0rc1"
RUN mim install mmdet==3.2.0
RUN pip install torchmetrics
RUN pip install scikit-learn
RUN pip install prettytable
RUN pip install imagesize
RUN pip install networkx
RUN pip install opencv-python
RUN pip install yapf==0.40.1

