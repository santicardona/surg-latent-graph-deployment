Instrucciones

0. Crea una nueva carpeta y abre vscode ahi
1. Instalar Anaconda en WSL. Revisa que functione corriendo `conda --version` desde wsl.
2. Estando aún en wsl, corre `sudo apt-get git` para instalar git
3. Ahora vamos a clonar los repositories que necesitamos

   - git clone https://github.com/open-mmlab/mmdetection.git
   - git clone https://github.com/CAMMA-public/SurgLatentGraph.git

4. Environment variables

   - En el terminal: `echo 'export MMDETECTION=$PWD/mmdetection' >> ~/.bashrc`
   - En el terminal: `echo 'export PYTHONPATH="$PYTHONPATH:$PWD/SurgLatentGraph"' >> ~/.bashrc`
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

7. Crear los datos. Corre estos comandos uno tras otro
   ```bash
   cd SurgLatentGraph && mkdir -p data/mmdet_datasets && cd data/mmdet_datasets
   wget https://s3.unistra.fr/camma_public/datasets/endoscapes/endoscapes.zip 
   unzip encoscapes.zip && rm endoscpaes.zip && cd ../..
   ```

8. Selecciona el dataset
   ```bash
   cd configs/models
   ./select_dataset.sh endoscapes
   cd ../..
   ```

9. Intenta correr un training
   ```bash
   mim train mmdet configs/models/faster_rcnn/lg_faster_rcnn.py
   ```


## Windows

0. Crea una nueva carpeta y abre vscode ahi
3. Ahora vamos a clonar los repositories que necesitamos. Desde el CMD

   - git clone https://github.com/open-mmlab/mmdetection.git
   - git clone https://github.com/CAMMA-public/SurgLatentGraph.git

4. Environment variables. Es importante desde acá no cerrar el terminal en el que estás trabajando.

   - En el CMD: `set MMDETECTION=%cd%\mmdetection`
   - En el CMD: `set PYTHONPATH=%PYTHONPATH%;%cd%\SurgLatentGraph`

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

7. Crear los datos. Corre estos comandos uno tras otro

   - En la carpeta `SurgLatentGraph` crea las carpetas `data/mmdet_datasets`
   - Decarga el archivo .zip de endoscapes desde https://s3.unistra.fr/camma_public/datasets/endoscapes/endoscapes.zip
   - Descomprime el archivo en la carpeta `mmdet_datasets`

8. Selecciona el dataset:
   - Ve a `SurgLatentGraph/configs/models` y corre en el cmd: `bash ./select_dataset.sh endoscapes`

9. Vuelve a la carpeta de `SurgLatentGraph` y corre 
   ```bash
   mim train mmdet configs/models/faster_rcnn/lg_faster_rcnn.py
   ```