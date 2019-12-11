# coding: utf-8
import math
import numpy as np
import pandas as pd

from sklearn import preprocessing
#from sklearn.cross_validation import train_test_split
from sklearn.model_selection import train_test_split

X_columns = 5486  #�÷�����
Node_list = [2048, 2048, 1024, 1024, 512]   #����
number_of_class = 2    #���Ӻ��� ������

 
# �з� DNN �� ���� ########################
from keras import layers, models, initializers
from keras.utils import to_categorical 
 
class DNN(models.Sequential):
    def __init__(self, Nin, Nh_l, Nout):
        super().__init__()
        
        self.add(layers.Dense(Nh_l[0], activation='relu', input_shape=(Nin,), name='Hidden-1',
                            kernel_initializer=initializers.glorot_uniform())) 
        self.add(layers.Dropout())
        
        self.add(layers.Dense(Nh_l[1], activation='relu', name='Hidden-2', 
                            kernel_initializer=initializers.glorot_uniform())) 
        self.add(layers.Dropout())
        
        self.add(layers.Dense(Nh_l[2], activation='relu', name='Hidden-3'))
        # �� ���� ������
        self.add(layers.Dense(Nh_l[3], activation='relu', name='Hidden-4'))
        # �ټ� ���� ������
        self.add(layers.Dense(Nh_l[4], activation='relu', name='Hidden-5'))
        
        self.add(layers.Dense(Nout, activation='softmax'))
        # �ս��Լ� : ���� ��Ʈ��
        self.compile(loss='categorical_crossentropy',optimizer='adam',metrics=['accuracy'])
 
 
# ������ �Է�
from keras import datasets
from keras.utils import np_utils
''' 
(X_train, y_train), (X_test, y_test) = datasets.mnist.load_data()  >>>>���ͳݵ�����

y_train = np_utils.to_categorical(y_train)
y_test = np_utils.to_categorical(y_test)
 
L, W, H = X_train.shape
X_train = X_train.reshape(-1, W * H)
X_test = X_test.reshape(-1, W * H)
 
X_train = X_train / 255.0
X_test = X_test / 255.0
'''
min_max_scaler = preprocessing.MinMaxScaler(feature_range=(-1,1))
# ------------------------------------------------------------------------------
df = pd.read_csv('abd8.csv', header=0)
df.columns = ['age','marry','aver_amt','CUST_NEW_DT','SHTR_CRGD_CD',
              'LNTR_CRGD_CD','ASS_CRGD_CD','BSS_CRED_GRCD','CARD_ASS_GRCD',
              'CARD_BSS_GRCD','CORP_CRGD_CD','card_acept_count',
              'card_acept_bal','ilsi_acept_count','halbu_acept_bal',
              'cach_acept_bal','card_bal','ilsi_aver','hanbu_aver',
              'cash_aver','card_aver','visa_count','check_count','pay_count',
              'atm_count','auto_count','tele_count','inter_count',
              'mobil_count','out_yn']
X = df[df.columns[:-1]]  # <<<<< ������ �÷��� �������� �κ�

X = np.array(X)
X = min_max_scaler.fit_transform(X)
print('X:',X.shape)

#Y = df['out_yn'].map(lambda x: 1.0 if x=='Y' else 0.0) 
# <<<<<< Y�� 1�� N�� 0���� �ٲٴ� �κ�

Y = df['out_yn'].map(lambda x: float(x))
Y = np.array(Y)
print('Y:',Y.shape)


# train_x = X[:int(X.shape[0]*0.7)]
# train_y = Y[:int(Y.shape[0]*0.7)]
# test_x = X[int(X.shape[0]*0.7):]
# test_y = Y[int(Y.shape[0]*0.7):]
# print('train_x:',train_x.shape)
# print('train_y:',train_y.shape)
# print('test_x:',test_x.shape)
# print('test_y:',test_y.shape) 
  
#�Ʒ�, �׽�Ʈ ������ ����
#X_train,X_test,Y_train,Y_test = train_test_split(train_x,train_y,test_size=0.33)
X_train,X_test,Y_train,Y_test = train_test_split(X, Y, test_size=0.30)
# ------------------------------------------------------------------------------  
Y_train = to_categorical(Y_train)
Y_test = to_categorical(Y_test)
Y = to_categorical(Y)

# DNN�� ����Ͽ� �н��� �Ѵ�.
model = DNN(X_columns, Node_list, number_of_class)
history = model.fit(X_train, Y_train, epochs=5, batch_size=1000, 
                    validation_data=(X_test, Y_test))
performace_test = model.evaluate(X_test, Y_test, batch_size=1000)
print('Test Loss and Accuracy ->', performace_test)

result = model.predict(X_test)

print(result.shape)

from matplotlib import pyplot as plt


plt.figure(10)


plt.show()




