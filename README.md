# CVPDL-HW1
## Methods
### Model : DINO <img src="DINO/figs/dinosaur.png" width="30">

* The repository is cloned from the [official implementation](https://github.com/IDEA-Research/DINO) of the [DINO](https://arxiv.org/abs/2203.03605) and is modified to meet the requirements of CVPDL-HW1 (Marked by `# Modification for CVPDL-hw1`)
![method](DINO/figs/framework.png "model arch")

## Environment
```sh
(optional) git clone https://github.com/irisowo/CVPDL-HW1.git

cd CVPDL-HW1

# This will setup a conda environment and download checkpoint_best_regular.pth
bash ./build_Dino.sh
```
## Evaluate
```sh
python hw1_dataset/evaluate.py output.json $PATH_GROUND_TRUTH
```

## Run
* (optional) Before running models, download checkpoints from [google drive](https://drive.google.com/drive/folders/1PpPq0CuQjQeFZGVJ8KKrnnZVqShFdjK7?usp=sharing) or [official google drive](https://drive.google.com/drive/folders/1qD5m1NmK0kjE5hh-G17XUX751WsEG-h_)
* You can change the `pretrain_model_path` at the beginning of all scripts under scripts/
```sh
cd DINO
# Get the output.json for hw1-dataset/test
# Default output path : logs/submission_output/output.json
bash scripts/DINO_test.sh

# Get the bounded images for hw1-dataset/test without generating output.json
# Default output path : figs/imgs/IMG_xxxx.jpeg
bash scripts/DINO_visual.sh

# Train the model
# Default output path of model : logs/swin_lr1e5/xxxx.pth
bash scripts/DINO_train_swin.sh

# Evaluate certain checkpoints on validation set
bash scripts/DINO_eval.sh
```

* **Note** : For each bash file, you can manually configure the arguments at the beginning, for example :  
  * DINO_test.sh
    ```sh
    # modify model_name 
    model_name="swin_lr1e5"

    coco_path="../hw1_dataset"
    output_dir_path="logs/submission_output"

    config_path="config/DINO/DINO_4scale_swin.py"

    pretrain_model_path="logs/${model_name}/checkpoint0014.pth"


    CUDA_VISIBLE_DEVICES=0 python main.py \
        --output_dir $output_dir_path \
      -c $config_path \
      --coco_path $coco_path  \
      --pretrain_model_path $pretrain_model_path \
      --test \
      --options dn_scalar=100 embed_init_tgt=TRUE \
      dn_label_coef=1.0 dn_bbox_coef=1.0 use_ema=False \
      dn_box_noise_scale=1.0
    ```

## Result
* DINO with Swin-L backbone performs better than the onw with ResNet.
![mAP](DINO/figs/model_swin.png)
![mAP](DINO/figs/models.png)

## Directory Structure
```
CVPDL-HW1/
  ├── hw1_dataset/
  |
  ├── build_DINO.sh (see Environment)
  |
  └── DINO/
      |
      ├── main.py
      ├── engine.py
      |
      ├── scripts/ (see Run)
      |   ├──DINO_test.sh
      |   ├──DINO_visual.sh
      |   ├──DINO_train.sh
      |   └──DINO_eval.sh
      |
      ├── logs : (Outputs of models)
      |   |   
      |   ├──R50-12/
      |   |   ├──test/output.json
      |   |   └──checkpoint_best_regular.pth
      |   |
      |   ├──R50-24/
      |   |   ├──test/output.json
      |   |   └──checkpoint_best_regular.pth
      |   |
      |   └──R50-36/
      |       ├──test/output.json
      |       └──checkpoint_best_regular.pth
      |
      ├── config/DINO
      |   └──DINO_4scale.py
      |
      └── analyze.py
          : plot the mAP line chart according to logs/{model}/log.txt
```
