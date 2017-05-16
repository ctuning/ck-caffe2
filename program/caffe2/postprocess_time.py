#
# Convert raw output of the Caffe2 'time' command
# to the CK timing format.
#
# Developers:
#   - Grigori Fursin, cTuning foundation / dividiti, 2017
#   - Anton Lokhmotov, dividiti, 2017
#

import json
import os
import re
import sys

def ck_postprocess(i):
    ck=i['ck_kernel']
    rt=i['run_time']
    deps=i['deps']

    d={}

    env=i.get('env',{})

    # Load both stderr and stdout. Concatenate into one list.
    # NB: This assumes that Caffe iterates only once (--iterations=1).
    # Otherwise, looping over the log would be required.
    rf1=rt['run_cmd_out1']
    rf2=rt['run_cmd_out2']

    lst=[]

    if os.path.isfile(rf1):
       r=ck.load_text_file({'text_file':rf1,'split_to_list':'yes'})
       if r['return']>0: return r
       lst+=r['lst']
    if os.path.isfile(rf2):
       r=ck.load_text_file({'text_file':rf2,'split_to_list':'yes'})
       if r['return']>0: return r
       lst+=r['lst']

    for l in lst:
        j=l.find('per iter: ')
        if j>0:
           l=l[j+9:].strip()
           j=l.find('. ')
           if j>0:
              l=l[:j]
              f=float(l)

              d['time_fwbw_ms'] = f
              d['time_fwbw_s']= f*1e-3

              d['post_processed']='yes'
              # Internal CK key to show overall time.
              d['execution_time']=f*1e-03

    rr={}
    rr['return']=0
    if d.get('post_processed','')=='yes':
        # Save to file.
        r=ck.save_json_to_file({'json_file':'tmp-ck-timer.json', 'dict':d})
        if r['return']>0: return r
    else:
        rr['return']=1
        rr['error']='failed to find total time in Caffe2 output'

    return rr

# Do not add anything here!
