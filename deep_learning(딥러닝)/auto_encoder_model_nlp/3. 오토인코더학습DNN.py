import os
import json
import numpy as np
import pandas as pd
import glob
import math

from keras import layers, models
from keras.models import Model, Sequential, load_model
from keras.layers import Input, Dense
from sklearn import preprocessing


from numpy import dot
from numpy.linalg import norm
from konlpy.tag import Kkma
from collections import Counter

kkma=Kkma() 
min_max_scaler = preprocessing.MinMaxScaler(feature_range=(0.,1.))

def Measure_cosine_similarity(Query_vector, target_vector):
    get_dot = dot(Query_vector, target_vector)
    get_norm = norm(Query_vector)*norm(target_vector)
    get_simil = get_dot/get_norm
    return min(get_simil,1.0)

def Query_vector_genarator(st,df1):
    nouns=[]
    pos = kkma.pos(st)
    if len(st) > 0 :
        for keyword, type in pos:
            if type == "NNG" or type == "NNP":
                if keyword in df1.columns:
                    nouns.append(keyword)

        count=Counter(nouns)
#     print(count)   
    
    df1 = df1.append(count,ignore_index=True)
#     print(df1)
#     print(df1)
#     df1 = df1.rename(index=["Query"])
#     print(df1)
    df1 = df1.fillna(0)
#     print(df1)
    for colname in df1.columns:
        df1[colname]=df1[colname].map(lambda y:math.log10(y+1) if y > 0.0 else y )
    return df1

def onehot_encode(target):
    num_arr = np.unique(target, axis=0)
    num = num_arr.tolist()
    result_list = []
    for tar in target:
        n_arr = np.zeros(num_arr.shape[0])
        n_arr[num.index(tar)] = 1
        result_list.append(n_arr)
        
    return np.array(result_list), num

def onehot_decode(one_hot, class_list):
    result_list = []
    for tar in one_hot:
        tar_index = tar.argmax()
        max_value = tar.max()
        result_list.append(class_list[tar_index])
    return result_list, max_value

###################################################################
df = pd.read_csv('D:/OneDrive/법률문서/질의문테이블.csv', header=0, encoding='utf-8')

X = df[df.columns[2:]]  
X = np.array(X)
Y = df[df.columns[1]]
Y = np.array([column for column in Y])

EY, class_list = onehot_encode(Y)
result_list = onehot_decode(EY, class_list)

###################################################################
df1=pd.DataFrame(columns=(df.columns[2:]),dtype=float)
######################################################################
files = glob.glob("D:/OneDrive/법률문서/법률문서 데이터/*.txt")

index_dict={}
f1=open("D:/OneDrive/법률문서/추론결과N.txt", 'w', encoding='utf-8')
model = load_model('resources/DNNmodel2000.h5')
model.summary()

total=0
error=0

for x in files:
    f = open(x, 'r', encoding='utf-8')
    lines= f.read().count("\n")
    f.close()
    f = open(x, 'r', encoding='utf-8')
    for  j in range(lines):
        st=f.readline()
        df1 = Query_vector_genarator(st,df1)
        query_vector = np.array([df1.loc[0].tolist()])
        one_hot = model.predict(query_vector)
        result, max_value = onehot_decode(one_hot, class_list)
       
        string = []
        string.append(str(max_value))
        string.append(result[0])
        string.append(x.replace('\\','/').split('/')[-1][:-4])
        string.append(st)
        total = total + 1
        if string[1] == string[2] :
            concat_string = string[0]+" | "+string[1]+" | "+string[2] +" | "+string[3]
           
        else :
            concat_string = "[*]" + string[0]+" | "+string[1]+" | "+string[2] +" | "+string[3]
            error = error + 1
        print(total,concat_string)
        f1.write(concat_string)   
        df1=df1.drop([0])
#         print(df1)
    f.close()
concat_string="**********************************************************************************" 
print(concat_string)
f1.write(concat_string)     
concat_string="*******************  "+ "전체처리건수 :" + str(total) + "오탐건수 :" + str(error) 
print(concat_string)
f1.write(concat_string)     
f1.close()   
######################################################################

