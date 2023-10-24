# Define pathes
model_name="swin_lr1e5"
output_dir_path="logs/submission_visual"
coco_path="../hw1_dataset"
config_path="config/DINO/DINO_4scale_swin.py"
pretrain_model_path="logs/${model_name}/checkpoint0014.pth"
visualize_path="figs/imgs"


# Execute main.py with "--visualize_mode"
python main.py \
  	--output_dir $output_dir_path \
	-c $config_path \
	--coco_path $coco_path  \
	--pretrain_model_path $pretrain_model_path \
	--test \
	--options dn_scalar=100 embed_init_tgt=TRUE \
	dn_label_coef=1.0 dn_bbox_coef=1.0 use_ema=False \
	dn_box_noise_scale=1.0 \
	--visualize_mode \
	--visualize_path=$visualize_path