
from konlpy.tag import Kkma
from collections import Counter
import glob
import json
import csv


kkma=Kkma() 
stop_word=[]

f = open('한국어불용어100.txt', 'r', encoding='utf-8')
rdr = csv.reader(f)
for line in rdr:
    print(line)
    stop_word.append(line[0].split('\t')[0])
                    
print(stop_word)                    
f.close() 

files = glob.glob("D:/법률문서/all.txt")
nouns=[]



for x in files:
    f = open(x, 'r', encoding='utf-8')
    st=f.read()

    if len(st) > 0 :
        pos = kkma.pos(st)
        for keyword, type in pos:
            if type == "NNG" or type == "NNP":
                if keyword not in stop_word:
                    nouns.append(keyword)
    
count=Counter(nouns)
print(count)
print(count.most_common(6000))
data_dict = count.most_common(6000)

dataset_json = 'resources/dataset/{}_dataset.json'.format('recommendation')
with open(dataset_json, "w", encoding='UTF-8') as f:
            json_data = json.dumps(data_dict, ensure_ascii=False)
            f.write(json_data)     
# count=Counter(hannanum.nouns(st))
# print(count)
# print(count.most_common(2)) 