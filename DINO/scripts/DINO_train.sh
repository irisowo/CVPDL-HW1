# Define model_name and pathes
model_name="R50-24"
output_dir_path="logs/${model_name}"
coco_path="../hw1_dataset"
config_path="config/DINO/DINO_4scale.py"
pretrain_model_path="logs/${model_name}/checkpoint_best_regular.pth"


# Start training
CUDA_VISIBLE_DEVICES=0 python main.py \
	--output_dir $output_dir_path \
	-c $config_path \
	--coco_path $coco_path \
	--options dn_scalar=100 embed_init_tgt=TRUE \
	dn_label_coef=1.0 dn_bbox_coef=1.0 use_ema=False \
	dn_box_noise_scale=1.0 \
	--pretrain_model_path $pretrain_model_path
