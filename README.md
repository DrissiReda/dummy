# NEWDARK #

### Requirements ###

* gcc version >= 4.9
* [CUDA 8.0](https://developer.nvidia.com/cuda-downloads) Only if you want to use gpu in processing
* [OpenCV 3.x](https://sourceforge.net/projects/opencvlibrary/files/opencv-win/3.2.0/opencv-3.2.0-vc14.exe/download)
* GPU with CC>=2.0 or 3.0 if you need cuDNN. Refer to this [link]( https://en.wikipedia.org/wiki/CUDA#GPUs_supported)
### Pre-trained models that we found (their config files van be found in `cfg/`) ###
* `yolo.cfg` (194 MB COCO-model) - require 4 GB GPU-RAM: http://pjreddie.com/media/files/yolo.weights
* `yolo-voc.cfg` (194 MB VOC-model) - require 4 GB GPU-RAM: http://pjreddie.com/media/files/yolo-voc.weights
* `tiny-yolo.cfg` (60 MB COCO-model) - require 1 GB GPU-RAM: http://pjreddie.com/media/files/tiny-yolo.weights
* `tiny-yolo-voc.cfg` (60 MB VOC-model) - require 1 GB GPU-RAM: http://pjreddie.com/media/files/tiny-yolo-voc.weights
* `yolo9000.cfg` (186 MB Yolo9000-model) - require 4 GB GPU-RAM: http://pjreddie.com/media/files/yolo9000.weights

### Compiling ###

You can `make` directly, but you might want to change a few flags in the
Makefile.
* `GPU=1` to build with CUDA to accelerate by using GPU (CUDA should be in `/use/local/cuda`)
* `CUDNN=1` to build with cuDNN v5/v6 to accelerate training by using GPU (cuDNN should be in `/usr/local/cudnn`)
* `OPENCV=1` to build with OpenCV 3.x/2.4.x - allows to detect on video files and video streams from network cameras or web-cams
* `DEBUG=1` to build the debug version
* `OPENMP=1` to build with OpenMP support to accelerate Yolo by using multi-core CPU
* `LIBSO=1` to build a library `dummy.so`, currently very buggy, not a good idea to use it, but it will compile with no errors

### Running ###

You can use the short scripts to run it after you built the project, just run scripts from root
* `dummy-video` takes 1 argument (also works with network streams like rtsp)
* `dummy-image` takes 0-n arguments which will be the path of the images you want to process, by default it goes through the sample of the dataset used
* `dummy-cam` takes 0-1 argument, the id of your webcam (in case you don't know what to put here just put 0 which will be the default value)

You can also change/add options like threshold percents (by default 0.24 or 24%) or which gpu to use (defaults to your primary nvidia gpu)

Results will always be in predictions/ folder.

### Configuration ### 

These are some of the config options/parameters when training and when detecting. Many things are more or less self-explanatory (size, stride, batch_normalize, max_batches, width, height, channels ...).
##### [net]
 - batch: How many images+labels are used in the forward pass to compute a gradient and update the weights via backpropagation.
 - subdivisions: The batch is subdivided in this many "blocks". The images of a block are ran in parallel on the gpu.
 - decay: A term to diminish the weights to avoid having large values.
 - channels: If you need help with it, it's better explained with this image :

On the left we have a single channel with 4x4 pixels, The reorganization layer reduces the size to half then creates 4 channels with adjacent pixels in different channels. 
![figure](https://i.stack.imgur.com/238m5.png)
 - momentum:the new gradient is computed by *momentum* * *previous_gradient* + (1-*momentum*) * *gradient_of_current_batch*. Makes the gradient more stable.
 - adam: Uses the adam optimizer, never tried it, not sure how well it works
 - burn_in: For the first x batches, slowly increase the learning rate until its final value (your *learning_rate* parameter value). Use this to decide on a learning rate by monitoring until what value the loss decreases (before it starts to diverge).
 - policy=steps: Use the steps and scales parameters below to adjust the learning rate during training
 - steps=500,1000: Adjust the learning rate after 500 and 1000 batches
 - scales=0.1,0.2: After 500, multiply the LR by 0.1, then after 1000 multiply again by 0.2

##### [layers]
 - filters: How many convolutional kernels there are in a layer.
 - activation: Activation function, relu, leaky relu, etc. See src/activations.h
 - stopbackward: Do backpropagation until this layer only. Put it in the panultimate convolution layer before the first yolo layer to train only the layers behind that, e.g. when using pretrained weights.
 - random: Put in the yolo layers. If set to 1 do data augmentation by resizing the images to different sizes every few batches. Use to generalize over object sizes.
 
 
![Darknet Logo](http://pjreddie.com/media/files/darknet-black-small.png)

[Darknet](http://pjreddie.com/darknet) and [yolo](https://arxiv.org/pdf/1506.02640.pdf) are not mine 
