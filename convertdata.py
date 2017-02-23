import sys
import re
import os
import dataloader
from collections import defaultdict

FILE_PATH = 'D:\\Working\\UF\\CPR\\'

print 'PID, Trial, Total, Correct, AvgDepth, AvgRecoil, AvgRate'

dirs = os.listdir(FILE_PATH)
dirs.sort()
participants = defaultdict(int)

for filename in dirs:
    if not filename.endswith('.tsv'):
        continue

    fullpath = os.path.join(FILE_PATH, filename)
    loader = dataloader.DataLoader(fullpath)

    compressions = loader.get_compressions()
    avg_depth = loader.get_average_depth()
    avg_recoil = loader.get_average_recoil()
    avg_rate = loader.get_average_rate()

    correct = 0
    for compression in compressions:
        if compression.is_correct():
            correct += 1
    percent_correct = correct / float(len(compressions))

    pid = int(re.match(r'CPR_(\d+)_.*\.tsv', filename).group(1))
    participants[pid] += 1

    values = []
    values.extend((pid, participants[pid], len(compressions), correct, avg_depth, avg_recoil, avg_rate))

    row = ','.join(map(str, values))
    print row
