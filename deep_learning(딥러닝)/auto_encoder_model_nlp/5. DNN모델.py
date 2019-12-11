# coding: utf-8
import numpy as np
import pandas as pd

X_columns = 5486  
Node_list = [4096, 4096, 4096, 2048, 2048]   
number_of_class = 262   

from keras import layers, models, initializers
from keras.utils import to_categorical 
from keras.models import Model, Sequential, load_model
 
def DNN(Nin, Nh_l, Nout):
    model = Sequential()
    model.add(layers.Dense(Nh_l[0], activation='relu', input_shape=(Nin,), name='Hidden-1',
                        kernel_initializer=initializers.glorot_uniform())) 
    model.add(layers.Dropout(0.7))
    model.add(layers.Dense(Nh_l[1], activation='relu', name='Hidden-2', 
                        kernel_initializer=initializers.glorot_uniform())) 
    model.add(layers.Dropout(0.7))
    model.add(layers.Dense(Nh_l[2], activation='relu', name='Hidden-3', 
                        kernel_initializer=initializers.glorot_uniform())) 
    model.add(layers.Dropout(0.7))
    model.add(layers.Dense(Nh_l[3], activation='relu', name='Hidden-4', 
                        kernel_initializer=initializers.glorot_uniform())) 
    model.add(layers.Dropout(0.7))
    model.add(layers.Dense(Nh_l[4], activation='relu', name='Hidden-5', 
                        kernel_initializer=initializers.glorot_uniform())) 
    model.add(layers.Dropout(0.7))
    model.add(layers.Dense(Nout, activation='softmax'))
    return model

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
    for one_acc in one_hot:
        one_acc_index = one_acc.argmax()
        print(one_acc.max())
        result_list.append(class_list[one_acc_index])
    return result_list


# ------------------------------------------------------------------------------
df = pd.read_csv('D:/OneDrive/법률문서/질의문테이블.csv', header=0, encoding='utf-8')

X = df[df.columns[2:]]  
X = np.array(X)
Y = df[df.columns[1]]
Y = np.array([column for column in Y])

print('X:',X.shape)
print('Y:',Y.shape)
# print('X:',X)
# print('Y:',Y)

EY, class_list = onehot_encode(Y)
print('=== one hot ecode ===\n{}'.format(EY))
print('=== class list ===\n{}'.format(class_list))


print('X:',X.shape)
print('Y:',Y.shape)
print('X:',X)
print('Y:',Y)


model = DNN(X_columns, Node_list, number_of_class)

model.compile(loss='categorical_crossentropy',optimizer='adam',metrics=['accuracy'])

history = model.fit(X, EY, epochs=2000, batch_size=1000) 

model.save('resources/DNNmodel2200.h5')




