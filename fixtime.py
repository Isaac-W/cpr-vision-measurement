import re
import os
import csv
from datetime import datetime
from datetime import timedelta

TIME_FORMAT = '%m-%d-%y_%H:%M:%S'

FILE_PATH = 'D:\\Working\\UF\\CPR\\'

dirs = os.listdir(FILE_PATH)
dirs.sort()

for filename in dirs:
    if not filename.endswith('.tsv'):
        continue

    fullpath = os.path.join(FILE_PATH, filename)
    pid = int(re.match(r'CPR_(\d+)_.*\.tsv', filename).group(1))

    if pid > 6:
        continue

    cur_lines = []
    cur_time = ''

    with open(fullpath) as csvfile:
        # Export to file
        namename, ext = os.path.splitext(filename)
        newpath = os.path.join(os.path.join(FILE_PATH, 'fixed'), namename + '_fixed' + ext)

        with open(newpath, 'w') as newfile:
            newfile.write('Index\tTime\tOrigin\tPosition\tRate\tDepth\tRecoil\tStatus\n')

            reader = csv.DictReader(csvfile, delimiter='\t')
            for row in reader:
                # Index	Time	            Origin	Position	    Rate	Depth	Recoil	Status
                # 0     02-21-17_13:52:26	280 	-0.277908970785

                # Add lines and convert time
                if cur_time != row['Time']:
                    # EXPORT ALL THE LINES WITH THE FIXED TIME
                    time_delta = 33
                    start_delta = (30 - len(cur_lines)) * time_delta

                    # Fix times
                    for i, line in enumerate(cur_lines):
                        time = datetime.strptime(line['Time'], '%m-%d-%y_%H:%M:%S')
                        ms = start_delta + (time_delta * i)
                        new_time = time + timedelta(milliseconds=ms)
                        timestr = new_time.strftime('%m-%d-%y_%H:%M:%S.%f')

                        # Print to file
                        rowrow = '\t'.join([line['Index'], timestr, line['Origin'], line['Position'], line['Rate'], line['Depth'], line['Recoil'], line['Status']])
                        newfile.write(rowrow + '\n')

                    cur_lines = []

                # Add time and line to list
                cur_time = row['Time']
                cur_lines.append(row)

            # EXPORT ALL THE LINES WITH THE FIXED TIME
            time_delta = 33
            start_delta = (30 - len(cur_lines)) * time_delta

            # Fix times
            for i, line in enumerate(cur_lines):
                time = datetime.strptime(line['Time'], '%m-%d-%y_%H:%M:%S')
                ms = start_delta + (time_delta * i)
                new_time = time + timedelta(milliseconds=ms)
                timestr = new_time.strftime('%m-%d-%y_%H:%M:%S.%f')

                # Print to file
                rowrow = '\t'.join([line['Index'], timestr, line['Origin'], line['Position'], line['Rate'], line['Depth'], line['Recoil'], line['Status']])
                newfile.write(rowrow + '\n')

