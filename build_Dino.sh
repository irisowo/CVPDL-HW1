conda create --name CVPDL python=3.7.3 -y
conda activate CVPDL
pip install torch==1.10.0+cu111 torchvision==0.11.0+cu111 torchaudio==0.10.0 -f https://download.pytorch.org/whl/torch_stable.html

cd DINO
pip install -r requirements.txt

# Compiling CUDA operators (by DINO official)
cd models/dino/ops
python setup.py build install
# unit test (should see all checking is True)
python test.py
cd ../../..

# download backbone
cd logs/backbone
wget https://github.com/SwinTransformer/storage/releases/download/v1.0.0/swin_large_patch4_window12_384_22k.pth

# download checkpoint
cd logs/swin
# default : 0029_4scale_swin
gdown https://drive.google.com/uc?id=1CrzFP0RycSC24KKmF5k0libLRJgpX9x0
cd ../..