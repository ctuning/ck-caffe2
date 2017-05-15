# Unifying and optimizing AI using Collective Knowledge workflow framework with JSON API

[![logo](https://github.com/ctuning/ck-guide-images/blob/master/logo-powered-by-ck.png)](https://github.com/ctuning/ck)
[![logo](https://github.com/ctuning/ck-guide-images/blob/master/logo-validated-by-the-community-simple.png)](http://cTuning.org)
[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

## Introduction

After spending most of our "research" time not on AI innovation but on dealing with numerous 
and ever changing AI engines, their API, and the whole software and hardware stack, 
we decided to take an alternative approach. 

[![logo](http://cknowledge.org/images/ai-cloud-resize.png)](http://cKnowledge.org/ai)

We started adding existing AI frameworks such as [Caffe](https://github.com/dividiti/ck-caffe), 
[Caffe2](https://github.com/ctuning/ck-caffe) and [TensorFlow](https://github.com/ctuning/ck-tensorflow) 
to the non-intrusive open-source [Collective Knowledge workflow framework (CK)](https://github.com/ctuning/ck)
to unify their customized installation across Linux, Windows, MacOS and Android, and provide 
simple JSON API for common operations such as prediction and training (see [demo](http://cKnowledge.org/ai/ck-api-demo)).

At the same time, CK allows us to continuously optimize ([1](https://arxiv.org/abs/1506.06256), [2](http://doi.acm.org/10.1145/2909437.2909449))
the whole AI stack (SW/HW/models) across diverse platforms from mobile devices and IoT to supercomputers 
in terms of accuracy, execution time, power consumption, resource usage and other costs with the
help of the community (see [public CK repo](http://cKnowledge.org/repo)).

See [cKnowledge.org/ai](http://cKnowledge.org/ai) for more details.

## Authors/contributors

* Grigori Fursin, [dividiti](http://dividiti.com) / [cTuning foundation](http://ctuning.org)
* Anton Lokhmotov, [dividiti](http://dividiti.com)

## Example of Caffe and Caffe2 unified installation on Ubuntu via CK

```
$ sudo apt install coreutils build-essential make cmake wget git python python-pip
$ sudo pip install jupyter pandas numpy scipy matplotlib scikit-image scikit-learn pyyaml protobuf

$ sudo pip install ck

$ ck pull repo:ck-caffe
$ ck pull repo:ck-caffe2

$ ck install package:lib-caffe-bvlc-master-cpu-universal --env.CAFFE_BUILD_PYTHON=ON
$ ck install package:lib-caffe2-master-eigen-cpu-universal --env.CAFFE_BUILD_PYTHON=ON

```

You can find detailed instructions to install Caffe (CPU, CUDA, OpenCL versions) via CK on Ubuntu, Gentoo, Yocto, Raspberry Pi, Odroid, Windows and Android [here](https://github.com/dividiti/ck-caffe/wiki/Installation). Caffe2 instructions are coming soon!

## Example of Caffe and Caffe2 unified classification on Ubuntu via CK

```
$ ck run program:caffe --cmd_key=classify
$ ck run program:caffe2 --cmd_key=classify
```

You can find and install additional Caffe and Caffe2 models via CK:
```
$ ck search package:* --tags=caffemodel
$ ck search package:* --tags=caffemodel2

$ ck install package:caffemodel-bvlc-googlenet
$ ck install package:caffemodel-bvlc-alexnet

$ ck install package:caffemodel2-deepscale-squeezenet-1.1
$ ck install package:caffemodel2-resnet50
```

## Online demo of a unified CK-AI API 


* [Simple demo](http://cknowledge.org/repo/web.php?template=ck-ai-basic) to classify images with
continuous optimization of DNN engines underneath, sharing of mispredictions and creation of a community training set;
and to predict compiler optimizations based on program features.

## Next steps

CK-Caffe, CK-Caffe2, CK-Tensorflow are part of an ambitious long-term and community-driven 
project to enable collaborative and systematic optimization 
of realistic workloads across diverse hardware 
in terms of performance, energy usage, accuracy, reliability,
hardware price and other costs
([ARM TechCon'16 talk](http://schedule.armtechcon.com/session/know-your-workloads-design-more-efficient-systems), 
[ARM TechCon'16 demo](https://github.com/ctuning/ck/wiki/Demo-ARM-TechCon'16), 
[DATE'16](http://tinyurl.com/zyupd5v), 
[CPC'15](http://arxiv.org/abs/1506.06256)).

We are working with the community to unify and crowdsource performance analysis 
and tuning of various DNN frameworks (or any realistic workload) 
using Collective Knowledge Technology:
* [CK-TensorFlow](https://github.com/dividiti/ck-tensorflow)
* [Android app for DNN crowd-benchmarking and crowd-tuning](https://play.google.com/store/apps/details?id=openscience.crowdsource.video.experiments)
* [CK-powered ARM workload automation](https://github.com/ctuning/ck-wa)

We continue gradually exposing various design and optimization
choices including full parameterization of existing models.

## Open R&D challenges

We use crowd-benchmarking and crowd-tuning of such realistic workloads across diverse hardware for 
[open academic and industrial R&D challenges](https://github.com/ctuning/ck/wiki/Research-and-development-challenges.mediawiki) - 
join this community effort!

## Related Publications with long term vision

```
@inproceedings{ck-date16,
    title = {{Collective Knowledge}: towards {R\&D} sustainability},
    author = {Fursin, Grigori and Lokhmotov, Anton and Plowman, Ed},
    booktitle = {Proceedings of the Conference on Design, Automation and Test in Europe (DATE'16)},
    year = {2016},
    month = {March},
    url = {https://www.researchgate.net/publication/304010295_Collective_Knowledge_Towards_RD_Sustainability}
}

@inproceedings{cm:29db2248aba45e59:cd11e3a188574d80,
    url = {http://arxiv.org/abs/1506.06256},
    title = {{Collective Mind, Part II: Towards Performance- and Cost-Aware Software Engineering as a Natural Science.}},
    author = {Fursin, Grigori and Memon, Abdul and Guillon, Christophe and Lokhmotov, Anton},
    booktitle = {{18th International Workshop on Compilers for Parallel Computing (CPC'15)}},
    publisher = {ArXiv},
    year = {2015},
    month = January,
    pdf = {http://arxiv.org/pdf/1506.06256v1}
}

```

* [All references with BibTex related to CK concept](https://github.com/ctuning/ck/wiki/Publications)

## Testimonials and awards

* 2017: We received [CGO test of time award](http://dividiti.blogspot.fr/2017/02/we-received-test-of-time-award-for-our.html) for our CGO'07 paper which later motivated creation of [Collective Knowledge](https://github.com/ctuning/ck)
* 2015: ARM and the cTuning foundation use CK to accelerate computer engineering: [HiPEAC Info'45 page 17](https://www.hipeac.net/assets/public/publications/newsletter/hipeacinfo45.pdf), [ARM TechCon'16 presentation and demo](http://schedule.armtechcon.com/session/know-your-workloads-design-more-efficient-systems), [public CK repo](https://github.com/ctuning/ck-wa)

## Feedback

Get in touch with CK-AI developers [here](https://github.com/ctuning/ck/wiki/Contacts). Also feel free to engage with our community via this mailing list:
* http://groups.google.com/group/collective-knowledge
