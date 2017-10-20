# From https://caffe2.ai/docs/tutorial-loading-pre-trained-models.html

def crop_center(img,cropx,cropy):
    y,x,c = img.shape
    startx = x//2-(cropx//2)
    starty = y//2-(cropy//2)    
    return img[starty:starty+cropy,startx:startx+cropx]

def rescale(img, input_height, input_width):
    print("Original image shape:" + str(img.shape) + " and remember it should be in H, W, C!")
    print("Model's input shape is %dx%d") % (input_height, input_width)
    aspect = img.shape[1]/float(img.shape[0])
    print("Orginal aspect ratio: " + str(aspect))
    if(aspect>1):
        # landscape orientation - wide image
        res = int(aspect * input_height)
        imgScaled = skimage.transform.resize(img, (input_width, res))
    if(aspect<1):
        # portrait orientation - tall image
        res = int(input_width/aspect)
        imgScaled = skimage.transform.resize(img, (res, input_height))
    if(aspect == 1):
        imgScaled = skimage.transform.resize(img, (input_width, input_height))
#    pyplot.figure()
#    pyplot.imshow(imgScaled)
#    pyplot.axis('on')
#    pyplot.title('Rescaled image')
    print("New image shape:" + str(imgScaled.shape) + " in HWC")
    return imgScaled

import sys
from caffe2.proto import caffe2_pb2
import numpy as np
import skimage.io
import skimage.transform
from matplotlib import pyplot
import os
from caffe2.python import core, workspace
import urllib2
import json

#import matplotlib
#matplotlib.use('Agg')

IMAGE_LOCATION = sys.argv[4]

# set paths and variables from model choice and prep image
mean = 128

# some models were trained with different image sizes, this helps you calibrate your image
INPUT_IMAGE_SIZE = 227

# make sure all of the files are around...
INIT_NET = sys.argv[1]
PREDICT_NET = sys.argv[2]

# load and transform image
img = skimage.img_as_float(skimage.io.imread(IMAGE_LOCATION)).astype(np.float32)
img = rescale(img, INPUT_IMAGE_SIZE, INPUT_IMAGE_SIZE)
img = crop_center(img, INPUT_IMAGE_SIZE, INPUT_IMAGE_SIZE)
print "After crop: " , img.shape
#pyplot.figure()
#pyplot.imshow(img)
#pyplot.axis('on')
#pyplot.title('Cropped')

# switch to CHW
img = img.swapaxes(1, 2).swapaxes(0, 1)
#pyplot.figure()
#for i in range(3):
#    # For some reason, pyplot subplot follows Matlab's indexing
#    # convention (starting with 1). Well, we'll just follow it...
#    pyplot.subplot(1, 3, i+1)
#    pyplot.imshow(img[i])
#    pyplot.axis('off')
#    pyplot.title('RGB channel %d' % (i+1))

# switch to BGR
img = img[(2, 1, 0), :, :]

# remove mean for better results
img = img * 255 - mean

# add batch size
img = img[np.newaxis, :, :, :].astype(np.float32)
print "NCHW: ", img.shape

# initialize the neural net

with open(INIT_NET, 'rb') as f:
    init_net = f.read()
with open(PREDICT_NET, 'rb') as f:
    predict_net = f.read()

p = workspace.Predictor(init_net, predict_net)

# run the net and return prediction
results = p.run([img])

# turn it into something we can play with and examine which is in a multi-dimensional array
results = np.asarray(results)
print "results shape: ", results.shape

results = np.delete(results, 1)
index = 0
highest = 0
arr = np.empty((0,2), dtype=object)
arr[:,0] = int(10)
arr[:,1:] = float(10)

for i, r in enumerate(results):
    # imagenet index begins with 1!
    i=i+1
    arr = np.append(arr, np.array([[i,r]]), axis=0)
    if (r > highest):
        highest = r
        index = i

print index, " :: ", highest

# lookup the code and return the result
# top 3 results
# sorted(arr, key=lambda x: x[1], reverse=True)[:3]

# now we can grab the code list
codes=sys.argv[3]

with open(codes) as f:
    response = f.read()

#response = json.loads(response1)

#codes =  "https://gist.githubusercontent.com/aaronmarkham/cd3a6b6ac071eca6f7b4a6e40e6038aa/raw/9edb4038a37da6b5a44c3b5bc52e448ff09bfe5b/alexnet_codes"
#response = urllib2.urlopen(codes)

# and lookup our result from the list

print("")
print("---------- Prediction for "+IMAGE_LOCATION+" ----------")
for line in response.split('\n'):
    code, result = line.partition(":")[::2]
    if (code.strip() == str(index)):
        print(str(highest) + ' - "'+result.strip()[1:-2]+'"')
