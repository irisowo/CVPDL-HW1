conda create --name CVPDL python=3.7.3 -y
conda activate CVPDL
conda install pytorch==1.9.0 torchvision==0.10.0 cudatoolkit=11.1 -c pytorch -c nvidia

cd DINO
pip install -r requirements.txt

# Compiling CUDA operators (by DINO official)
cd models/dino/ops
python setup.py build install
# unit test (should see all checking is True)
python test.py
cd ../../..