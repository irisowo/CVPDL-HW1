# configuration
output_dir_path="logs/R50-24"
coco_path="../hw1_dataset"
config_path="config/DINO/DINO_4scale.py"
pretrain_model_path="logs/R50-24/checkpoint_best_regular.pth"

# commands
python main.py \
	--output_dir $output_dir_path \
	-c $config_path \
	--coco_path $coco_path \
	--options dn_scalar=100 embed_init_tgt=TRUE \
	dn_label_coef=1.0 dn_bbox_coef=1.0 use_ema=False \
	dn_box_noise_scale=1.0 \
	--pretrain_model_path $pretrain_model_path
