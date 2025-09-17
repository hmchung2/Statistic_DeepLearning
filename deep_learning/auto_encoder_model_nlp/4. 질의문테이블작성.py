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

def Query_vector_genarator(st,df1,df2,index_dict):
    
    nouns=[]
    pos = kkma.pos(st)
    if len(st) > 0 :
        for keyword, type in pos:
            if type == "NNG" or type == "NNP":
                if keyword in df1.columns[1:]:
                    nouns.append(keyword)
        count=Counter(nouns)
    df2 = df2.append(count,ignore_index=True)
    df2 = df2.fillna(0)
    for colname in df2.columns[1:]:
        df2[colname]=df2[colname].map(lambda y:math.log10(y+1) if y > 0.0 else y )
    df2['계약서명'] = index_dict
    df3=df1.append(df2,ignore_index = True)
    df2=df2.drop([0])
    return df3


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

df_c=pd.DataFrame(columns=(['계약서명']),dtype=float)
df_o=pd.DataFrame(columns=(df.columns),dtype=float)

df1 = pd.concat([df_c, df_o], axis=1)
df2=pd.DataFrame(columns=(df1.columns),dtype=float)

files = glob.glob("D:/OneDrive/법률문서/법률문서 데이터/*.txt")

index_dict={}
count=0
for i, x in enumerate(files):
    
    f = open(x, 'r', encoding='utf-8')
    lines=f.read().count("\n")
    index_dict = x.replace('\\','/').split('/')[-1][:-4]
    f.close()
    
    f = open(x, 'r', encoding='utf-8')
    for  j in range(lines):
        st=f.readline()
        df1 = Query_vector_genarator(st,df1,df2,index_dict)
        count=count+1
        print(count, index_dict, st)
    
print('==========end of job=============================')
df1.to_csv("D:/OneDrive/법률문서/질의문테이블.csv", encoding='utf-8', mode='w')
