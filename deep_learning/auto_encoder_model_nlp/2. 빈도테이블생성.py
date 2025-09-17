'''
Created on 2019. 11. 28.

@author: chiho
'''
import os
import json
import numpy as np
import pandas as pd
import glob
import math

from konlpy.tag import Hannanum
from konlpy.tag import Kkma
from collections import Counter
from pandas import DataFrame
from sklearn import preprocessing

hannanum = Hannanum() 
hannanum.analyze  #구(Phrase) 분석
hannanum.morphs   #형태소 분석
hannanum.nouns    #명사 분석
hannanum.pos      #형태소 분석 태깅
kkma=Kkma() 


all_keyword_list = []
data_dict = {}
dataset_json = 'resources/dataset/{}_dataset.json'.format('recommendation')
with open(dataset_json, "r", encoding='UTF-8') as f:
    str_data = f.read()
    data_dict = json.loads(str_data)
    col = [ data[0] for data in data_dict]
    print("col=",col)
    df = pd.DataFrame(columns=(col),dtype=float)
    print(df)
    exit(1)
#     exit(1)
#     data_list = [0 for i in range(2000)]
#     df = pd.DataFrame([data_list], columns=(col))
#     print(df)
    

files = glob.glob("D:/OneDrive/법률문서/법률문서 데이터/*.txt")

index_dict={}
for i, x in enumerate(files):
    
    f = open(x, 'r', encoding='utf-8')
    st=f.read()
    
    nouns=[]
    pos = kkma.pos(st)
    for keyword, type in pos:
        if type == "NNG" or type == "NNP":
            if keyword in col:
                nouns.append(keyword)

    count=Counter(nouns)
    print(count)   
    df = df.append(count,ignore_index=True)
    index_dict[i]=x.replace('\\','/').split('/')[-1][:-4]

print('=====================================================')
df = df.rename(index=index_dict)
df = df.fillna(0)
print(len(col))
for colname in col:
#     print(colname)
#     print(len(df))
    df[colname]=df[colname].map(lambda y: math.log10(y+1) if y > 0.0 else y )

print(df)
df.to_csv("resources/빈도테이블D.csv", encoding='utf-8', mode='w')
