#
# Preprocessing Caffe templates
#
# Developer: Grigori Fursin, cTuning foundation, 2016
#

import json
import os
import re

def ck_preprocess(i):

    ck=i['ck_kernel']
    rt=i['run_time']
    deps=i['deps']

    env=i['env']
    nenv={} # new environment to be added to the run script

    hosd=i['host_os_dict']
    tosd=i['target_os_dict']
    remote=tosd.get('remote','')

    # Find template
    x=deps['caffemodel']
    cm_path=x['dict']['env']['CK_ENV_MODEL_CAFFE']

    template='deploy.prototxt'

    # load network topology template
    pp=os.path.join(cm_path,template)

    r=ck.load_text_file({'text_file':pp})
    if r['return']>0: return r
    st=r['string']

    # Substitute 
    st=st.replace('$#batch_size#$','1')

    # Generate tmp file
    rx=ck.gen_tmp_file({'prefix':'tmp-', 'suffix':'.prototxt', 'remove_dir':'yes'})
    if rx['return']>0: return rx
    fn=rx['file_name']

    # Record template
    r=ck.save_text_file({'text_file':fn, 'string':st})
    if r['return']>0: return r

    # Prepare path to model
    nenv['CK_CAFFE_MODEL_TOPOLOGY_FILE']=fn

    return {'return':0, 'new_env':nenv}

# Do not add anything here!
