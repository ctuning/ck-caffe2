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
[Caffe2](https://github.com/ctuning/ck-caffe2) and [TensorFlow](https://github.com/ctuning/ck-tensorflow) 
to the non-intrusive open-source [Collective Knowledge workflow framework (CK)](https://github.com/ctuning/ck).
CK allows to plug in various versions of AI frameworks together with libraries, compilers, tools, models
and data sets as unified and reusable components with JSON API, automate and customize their 
installation across Linux, Windows, MacOS and Android (rather than using ad-hoc scripts) 
and provide simple JSON API for common operations such as prediction and training (see [demo](http://cKnowledge.org/ai/ck-api-demo)).

At the same time, CK allows us to continuously optimize ([1](https://arxiv.org/abs/1506.06256), [2](http://doi.acm.org/10.1145/2909437.2909449))
the whole AI stack (SW/HW/models) across diverse platforms from mobile devices and IoT to supercomputers 
in terms of accuracy, execution time, power consumption, resource usage and other costs with the
help of the community (see [public CK repo](http://cKnowledge.org/repo)).

See [cKnowledge.org/ai](http://cKnowledge.org/ai) for more details.

## Authors/contributors

* [Grigori Fursin](http://fursin.net/research.html), dividiti / cTuning foundation
* [Anton Lokhmotov](http://dividiti.com), dividiti

## Example of Caffe and Caffe2 unified CPU installation on Ubuntu via CK

```
$ sudo apt install coreutils build-essential make cmake wget git python python-pip
$ sudo pip install jupyter pandas numpy scipy matplotlib scikit-image scikit-learn pyyaml protobuf

$ sudo pip install ck

$ ck pull repo --url=https://github.com/dividiti/ck-caffe
$ ck pull repo:ck-caffe2

$ ck install package:lib-caffe-bvlc-master-cpu-universal --env.CAFFE_BUILD_PYTHON=ON
$ ck install package:lib-caffe2-master-eigen-cpu-universal --env.CAFFE_BUILD_PYTHON=ON
```

## Example of Caffe and Caffe2 unified CUDA installation on Ubuntu via CK

If you have CUDA-compatible GPGPU with drivers, CUDA and cuDNN installed,
you can install Caffe and Caffe2 for GPGPU via CK as following
(CK will automatically find your CUDA installation):

```
$ ck install package:lib-caffe-bvlc-master-cuda-universal --env.CAFFE_BUILD_PYTHON=ON
$ ck install package:lib-caffe-bvlc-master-cudnn-universal --env.CAFFE_BUILD_PYTHON=ON
$ ck install package:lib-caffe2-master-eigen-cuda-universal --env.CAFFE_BUILD_PYTHON=ON
```
You can find detailed instructions to install Caffe (CPU, CUDA, OpenCL versions) via CK 
on Ubuntu, Gentoo, Yocto, Raspberry Pi, Odroid, Windows and Android [here](https://github.com/dividiti/ck-caffe/wiki/Installation). 
Caffe2 detailed instructions about customized CK builds are coming soon!

## Example of Caffe and Caffe2 unified classification on Ubuntu via CK

```
$ ck run program:caffe --cmd_key=classify
$ ck run program:caffe2 --cmd_key=classify
```

Note, that Caffe2, besides some very useful improvements, also changed various support programs 
and API. However, our approach helped our collaborators hide these changes via CK API and thus
protect higher-level experimental workflows!

You can find and install additional Caffe and Caffe2 models via CK:
```
$ ck search package:* --tags=caffemodel
$ ck search package:* --tags=caffemodel2

$ ck install package:caffemodel-bvlc-googlenet
$ ck install package:caffemodel-bvlc-alexnet

$ ck install package:caffemodel2-deepscale-squeezenet-1.1
$ ck install package:caffemodel2-resnet50
```

## Collaborative and unified benchmarking of DNN

Additional motivation to use CK wrappers for DNN is the possibility 
to assemble various experimental workflows, crowdsource experiments
and engage with the community to collaboratively solve complex problems 
([notes](https://www.researchgate.net/publication/304010295_Collective_Knowledge_Towards_RD_Sustainability)). 
For example, we added basic support to collaboratively evaluate various DNN engines
via unified CK API:

```
$ ck crowdbench caffe --env.BATCH_SIZE=5
$ ck crowdbench caffe2 --env.BATCH_SIZE=5 --user=i_want_to_ack_my_contribution
```

Performance results are continuously aggregated in the public [CK repository](http://cKnowledge.org/repo), 
however they can also be aggregated only on your local machine or in your workgroup - you just need to add flag "--local".

## Collaborative and unified optimization of DNN

We are now working to add our [universal, customizable and multi-objective CK autotuner](https://github.com/ctuning/ck/wiki/Autotuning)
to crowdsource optimization of the whole SW/HW/model/data set stack ([ARM TechCon'16](http://schedule.armtechcon.com/session/know-your-workloads-design-more-efficient-systems),
[paper 1](https://scholar.google.com/citations?view_op=view_citation&hl=en&user=IwcnpkwAAAAJ&citation_for_view=IwcnpkwAAAAJ:maZDTaKrznsC), 
[paper 2](https://arxiv.org/abs/1506.06256)).

We had lots of interest to this collaborative AI optimization approach powered by CK 
at the Embedded Vision Summit'17,  so please stay tuned ;) !

[![logo](http://cKnowledge.org/images/dividiti_arm_stand.jpg)](https://www.researchgate.net/publication/304010295_Collective_Knowledge_Towards_RD_Sustainability)

## Other DNN

We added similar support to install, use and evaluate [TensorFlow](https://www.tensorflow.org) via CK:

```
$ ck pull repo:ck-tensorflow

$ ck install lib-tensorflow-1.1.0-cpu
$ ck install lib-tensorflow-1.1.0-cuda

$ ck run program:tensorflow --cmd_key=classify

$ ck crowdbench tensorflow --env.BATCH_SIZE=5
```

## Online demo of a unified CK-AI API 

* [Simple demo](http://cknowledge.org/repo/web.php?template=ck-ai-basic) to classify images with
continuous optimization of DNN engines underneath, sharing of mispredictions and creation of a community training set;
and to predict compiler optimizations based on program features.

## Next steps

We would like to improve Caffe2 installation via CK on Windows and Android similar to [CK-Caffe](https://github.com/dividiti/ck-caffe/wiki/Installation).

## Long term vision

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
* [Android app for DNN crowd-benchmarking and crowd-tuning](https://play.google.com/store/apps/details?id=openscience.crowdsource.video.experiments)
* [CK-TensorFlow](https://github.com/ctuning/ck-tensorflow)
* [CK-Caffe](https://github.com/dividiti/ck-caffe)
* [CK-Caffe2](https://github.com/ctuning/ck-caffe2)

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
