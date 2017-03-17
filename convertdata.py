import sys
import re
import os
import dataloader
from collections import defaultdict
import matplotlib.pyplot as plt

FILE_PATH = 'D:\\Working\\UF\\CPR\\'
#FILE_PATH = 'D:\\Working\\UF\\CPR\\fixed'

print 'PID,Trial,Total,Correct,AvgDepth,AvgRecoil,AvgRate,NumBadDepth,NumBadRecoil,NumBadRate,GoodDepth,GoodRecoil,GoodRate,GoodDepthRecoil,GoodDepthRate,GoodRecoilRate'

dirs = os.listdir(FILE_PATH)
dirs.sort()
participants = defaultdict(int)

for filename in dirs:
    if not filename.endswith('.tsv'):
        continue

    fullpath = os.path.join(FILE_PATH, filename)
    loader = dataloader.DataLoader(fullpath)
    loader.plot()

    compressions = loader.get_compressions()
    avg_depth = loader.get_average_depth()
    avg_recoil = loader.get_average_recoil()
    avg_rate = loader.get_average_rate()

    bad_depth = 0
    bad_recoil = 0
    bad_rate = 0

    good_depth = 0
    good_recoil = 0
    good_rate = 0
    good_depth_recoil = 0
    good_depth_rate = 0
    good_recoil_rate = 0

    correct = 0
    for compression in compressions:
        if compression.is_correct():
            correct += 1
        else:
            if not compression.is_depth_correct():
                bad_depth += 1
            if not compression.is_recoil_correct():
                bad_recoil += 1
            if not compression.is_rate_correct():
                bad_rate += 1

        if compression.is_depth_correct():
            good_depth += 1
        if compression.is_recoil_correct():
            good_recoil += 1
        if compression.is_rate_correct():
            good_rate += 1

        if compression.is_depth_recoil_correct():
            good_depth_recoil += 1
        if compression.is_depth_rate_correct():
            good_depth_rate += 1
        if compression.is_recoil_rate_correct():
            good_recoil_rate += 1

    percent_correct = correct / float(len(compressions))

    depth_prop = good_depth / float(len(compressions))
    recoil_prop = good_recoil / float(len(compressions))
    rate_prop = good_rate / float(len(compressions))

    depth_recoil_prop = good_depth_recoil / float(len(compressions))
    depth_rate_prop = good_depth_rate / float(len(compressions))
    recoil_rate_prop = good_recoil_rate / float(len(compressions))

    pid = int(re.match(r'CPR_(\d+)_.*\.tsv', filename).group(1))
    participants[pid] += 1

    values = []
    values.extend((pid, participants[pid], len(compressions), percent_correct, avg_depth, avg_recoil, avg_rate, bad_depth, bad_recoil, bad_rate, depth_prop, recoil_prop, rate_prop, depth_recoil_prop, depth_rate_prop, recoil_rate_prop))

    row = ','.join(map(str, values))
    print row

plt.show()
