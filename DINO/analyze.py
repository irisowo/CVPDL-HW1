import numpy as np
import matplotlib.pyplot as plt
from matplotlib.pyplot import MultipleLocator
import json
EPOCH_NUM = 24


def read_mAP_from_log(fname):
    mAP_epochs = []
    with open(fname, 'r') as f:
        text = f.read()
        epochs = text.split("\n")
        
        for i in range(len(epochs)-1):
                info = json.loads(epochs[i])
                mAP_i = info['test_coco_eval_bbox'][0]
                mAP_epochs.append(mAP_i)

    return mAP_epochs


def plot_figure(mAPs):
    plt.title('mAP of models (on validation set)')
    plt.yticks(np.arange(0.35, 0.55, 0.05))
    plt.xticks(np.arange(0, EPOCH_NUM, 2))
    
    colors = ['cornflowerblue', 'palevioletred', 'lightseagreen']

    for i, (name, APs) in enumerate(mAPs.items()):
        x =  np.arange(EPOCH_NUM)
        plt.plot(x, APs, marker='o', c=colors[i], label=name)
        max_idx = np.array(APs).argmax()
        plt.text(x=(max_idx-1), y=0.47+0.01*i, c=colors[i], s=f'ep={max_idx}')



    plt.legend(loc='lower right')
    plt.savefig('figs/models.png')
    return


if __name__ == '__main__':

    models = ["R50-12", "R50-24", "R50-36"]
    models_mAPs = {}
    for m in models:
        log_path = f"logs/{m}/log.txt"
        models_mAPs[m] = read_mAP_from_log(log_path)
    
    plot_figure(models_mAPs)
