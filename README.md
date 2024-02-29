Instrucciones

0. Crea una nueva carpeta y abre vscode ahi
1. Instalar Anaconda en WSL. Revisa que functione corriendo `conda --version` desde wsl.
2. Estando aún en wsl, corre `sudo apt-get git` para instalar git
3. Ahora vamos a clonar los repositories que necesitamos

   - git clone https://github.com/open-mmlab/mmdetection.git
   - git clone https://github.com/CAMMA-public/SurgLatentGraph.git

4. Environment variables

   - En el terminal: `echo 'export MMDETECTION=$PWD/mmdetection' >> ~/.bashrc`
   - En el terminal: `echo 'export PYTHONPATH="$PYTHONPATH:%PWD/SurgLatentGraph"' >> ~/.bashrc`
   - En el terminal: `source ~/.bashrc`

5. Crear y activar el nuevo environment

   - En el terminal: `conda create -n latentgraph -y python=3.8 && conda activate latentgraph`

6. Ahora el resto. Corre estos comandos uno despues del otro:
   ```bash
   conda install -y pytorch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 pytorch-cuda=11.8 -c pytorch -c nvidia
   conda install -y -c dglteam/label/cu113 dgl
   pip install torch-scatter -f https://data.pyg.org/whl/torch-2.1.0+cu118.html
   pip install -U openmim
   mim install mmengine==0.7.4
   mim install "mmcv==2.0.0rc1"
   mim install mmdet==3.2.0
   pip install torchmetrics scikit-learn prettytable imagesize networkx opencv-python yapf==0.40.1
   ```
