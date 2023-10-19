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