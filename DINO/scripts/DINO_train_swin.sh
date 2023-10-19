coco_path="../hw1_dataset"
output_dir="logs/swin_lr1e5"
backbone_dir="./logs/backbone"
check_path="logs/swin/checkpoint0029_4scale_swin.pth"


CUDA_VISIBLE_DEVICES=0 python main.py \
	--output_dir $output_dir -c config/DINO/DINO_4scale_swin.py --coco_path $coco_path \
	--options dn_scalar=100 embed_init_tgt=TRUE \
	dn_label_coef=1.0 dn_bbox_coef=1.0 use_ema=False \
	dn_box_noise_scale=1.0 backbone_dir=$backbone_dir \
	--pretrain_model_path $check_path
