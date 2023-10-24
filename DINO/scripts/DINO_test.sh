# Define model_name and pathes
model_name="swin_lr1e5"

coco_path="../hw1_dataset"
output_dir_path="logs/submission_output"

config_path="config/DINO/DINO_4scale_swin.py"
pretrain_model_path="logs/${model_name}/checkpoint0014.pth"


# Download pretrined weights
if [ ! -f "$pretrain_model_path" ]
then
	cd "logs/${model_name}"
	gdown "https://drive.google.com/uc?export=download&id=1yy0Bf5etZYcCSx0kz__zQzKEXh1XKGjN"
	cd ../..
fi


# Execute main.py with "--test"
# Passing "--test" means taking images under "root / test" as our testing data
# See # Modification for CVPDL-hw1 in coco.py for details
CUDA_VISIBLE_DEVICES=0 python main.py \
  	--output_dir $output_dir_path \
	-c $config_path \
	--coco_path $coco_path  \
	--pretrain_model_path $pretrain_model_path \
	--test \
	--options dn_scalar=100 embed_init_tgt=TRUE \
	dn_label_coef=1.0 dn_bbox_coef=1.0 use_ema=False \
	dn_box_noise_scale=1.0