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
