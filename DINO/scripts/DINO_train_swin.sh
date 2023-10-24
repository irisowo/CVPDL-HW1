# Define model_name and pathes
model_name="swin_lr1e5"
coco_path="../hw1_dataset"
output_dir="logs/${model_name}"
backbone_dir="./logs/backbone"
pretrain_model_path="logs/${model_name}/checkpoint0029_4scale_swin.pth"
config_path="config/DINO/DINO_4scale_swin.py"


# Download pretrined weights of backbone
if [ ! -f "${backbone_dir}/swin_large_patch4_window12_384_22k.pth" ]
then
	cd $backbone_dir
	wget https://github.com/SwinTransformer/storage/releases/download/v1.0.0/swin_large_patch4_window12_384_22k.pth
	cd ../..
fi


# Download pretrined weights of DINO
mkdir -p "${output_dir}"
if [ ! -f "${pretrain_model_path}" ]
then
	cd "logs/${model_name}"
	gdown "https://drive.google.com/uc?export=download&id=1CrzFP0RycSC24KKmF5k0libLRJgpX9x0"
	cd ../..
fi


# Start training
CUDA_VISIBLE_DEVICES=0 python main.py \
	--output_dir $output_dir -c $config_path --coco_path $coco_path \
	--options dn_scalar=100 embed_init_tgt=TRUE \
	dn_label_coef=1.0 dn_bbox_coef=1.0 use_ema=False \
	dn_box_noise_scale=1.0 backbone_dir=$backbone_dir \
	--pretrain_model_path $pretrain_model_path
