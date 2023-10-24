# Define pathes
output_dir_path="logs/evaluate"
coco_path="../hw1_dataset"
checkpoint_path="logs/swin_lr1e5/checkpoint0014.pth"
config_path="config/DINO/DINO_4scale_swin.py"


# Execute main.py with "--eval"
CUDA_VISIBLE_DEVICES=0 python main.py \
  	--output_dir $output_dir_path \
	-c $config_path \
	--coco_path $coco_path  \
	--eval --resume $checkpoint_path \
	--options dn_scalar=100 embed_init_tgt=TRUE \
	dn_label_coef=1.0 dn_bbox_coef=1.0 use_ema=False \
	dn_box_noise_scale=1.0
