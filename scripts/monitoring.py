import json
import datetime
import sys
import time
from json import JSONDecodeError

http_list = range(100,600)
codes = []
dict_list = []
dict_item = {}
status_total_count = 0


try:
    timenow = datetime.datetime.now()
    current_time = timenow.strftime("%d %m %Y %X")
    f = open("monitoring.log", "a")
    with open('metrics.json') as json_file:
        data = json.load(json_file)
        for key in data:
            status_code = int(key['http_status'])
            codes.append(status_code)
            status_total_count += 1
except FileNotFoundError:
    f.write(f"{current_time} | Error: File 'test.json' was not found")
    f.write(f"\n")
    print("File 'test.json' was not found")
    time.sleep(5)
    raise
except KeyError:
    f.write(f"{current_time} | Error: Key error - 'http_status' does not exist in the json file")
    f.write(f"\n")
    print("Key error - 'http_status' does not exist in the json file")
    time.sleep(5)
    raise
except JSONDecodeError:
    f.write(f"{current_time} | Error: JSON decode error - there is a problem with how the file is formatted")
    f.write(f"\n")
    print("JSON decode error - there is a problem with decoding the json file, please make sure it is correctly formatted")
    time.sleep(5)
except ValueError:
    f.write(f"{current_time} | Error: Value error - value for 'http_status' is not a number")
    f.write(f"\n")
    print("Value error - value for 'http_status' is not a number")
    time.sleep(5)
    raise


for i in http_list:
    http_count = codes.count(int(i))
    if http_count >= 1:
        dict_item = {'http_status' : 'http_status{code=''"'+str(i)+'"''}' , 'count' : http_count}
        dict_list.append(dict_item)
    f = open("tracing.json", "w")
    f.write("# HELP http_total_status count \n"
            f"http_total_status {status_total_count}\n")
    f.write("# HELP http_status summary \n")
    for item in dict_list:
        f.write(str(item['http_status'])+" "+str(item['count'])+ "\n")
    f.close()
