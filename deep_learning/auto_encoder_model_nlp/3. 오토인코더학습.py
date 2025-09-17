import os
import json
import numpy as np
import pandas as pd
import glob
import math

from keras import layers, models
from keras.models import Model, Sequential
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
                if keyword in df.columns:
                    nouns.append(keyword)

        count=Counter(nouns)
#     print(count)   
#     print('=====================================================')
    df1 = df1.append(count,ignore_index=True)
#     print(df1)
#     df1 = df1.rename(index=["Query"])
#     print(df1)
    df1 = df1.fillna(0)
#     print(df1)
    for colname in df1.columns:
        df1[colname]=df1[colname].map(lambda y:math.log10(y+1) if y > 0.0 else y )
#     print(df1)
    
    return df1


df=pd.read_csv('resources/빈도테이블D.csv')
df1=pd.DataFrame(columns=(df.columns[1:]),dtype=float)
######################################################################
# st="식자재 거래하는 업체입니다. 세무신고와 증빙자료 구비 목적으로 물품구매계약서 같은 양식을 구하고 싶습니다. "
print("질의문을 입력하세요-->")
print()
st = input()

df1 = Query_vector_genarator(st,df1)
query_vector = np.array(df1.loc[0].tolist())
# print(query_vector)
####################################################################### 
target_vector_list = []
for df_row in df.iterrows():
    target_name = df_row[1].tolist()[0]
    target_vector = np.array(df_row[1].tolist()[1:])
#     print(target_vector)
    embedding = Measure_cosine_similarity(query_vector, target_vector)
#     print(embedding)
    target_vector_list.append({"embedding":embedding, "contract_name":target_name})

target_vector_list.sort(key=lambda top_ranking: top_ranking['embedding'],reverse=True)

for target_vector in target_vector_list[:10]:
    print(target_vector)
