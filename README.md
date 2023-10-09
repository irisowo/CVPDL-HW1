# CVPDL-HW1
## Methods
### Model : DINO <img src="DINO/figs/dinosaur.png" width="30">

* The repository is cloned from the [official implementation](https://github.com/IDEA-Research/DINO) of the [DINO](https://arxiv.org/abs/2203.03605) and is modified to meet the requirements of CVPDL-HW1
![method](DINO/figs/framework.png "model arch")

## Environment
```sh
git clone https://github.com/irisowo/CVPDL-HW1.git

cd CVPDL-HW1

# This will setup a conda environment
bash ./build_Dino.sh
```
## Evaluate
```sh
python hw1_dataset/evaluate.py output.json $PATH_GROUND_TRUTH
```

## Run
* Before running models, download checkpoints from [google drive](https://drive.google.com/drive/folders/1PpPq0CuQjQeFZGVJ8KKrnnZVqShFdjK7?usp=sharing) and modify `pretrain_model_path` in all script in scripts/
```sh
cd DINO

# Get the output.json for hw1-dataset/test
# Default output path : logs/{R50-12/R50-24/R50-36}/test/output.json
bash scripts/DINO_test.sh

# Get the bounded images for hw1-dataset/test without generating output.json
# Default output path : figs/imgs/IMG_xxxx.jpeg
bash scripts/DINO_visual.sh

# Train the model
bash scripts/DINO_train.sh

# Evaluate certain checkpoints on validation set
bash scripts/DINO_eval.sh
```

* **Note** : For each bash file, you can manually configure the arguments at the beginning, for example :  
  * DINO_test.sh
    ```sh
    # Manually configure the variables here
    model_name="R50-24"

    output_dir_path="logs/submission_output"
    coco_path="../hw1_dataset"
    config_path="config/DINO/DINO_4scale.py"
    pretrain_model_path="logs/${model_name}/checkpoint_best_regular.pth"

    # command
    python main.py \
      --output_dir $output_dir_path \
      -c $config_path \
      --coco_path $coco_path  \
      --pretrain_model_path $pretrain_model_path \
      --test
      ...
    ```

## Result
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
      ├── logs : outputs of models
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