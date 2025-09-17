import numpy as np
import pandas as pd
target = np.array(["abc",  "aaa" , "ccc" , "ddd" , "abc"])
# target = np.array([1,  1, 2, 2, 0])
print(target)

def onehot_encode(target):
    num_arr = np.unique(target, axis=0)
    num = num_arr.tolist()
    result_list = []
    for tar in target:
        n_arr = np.zeros(num_arr.shape[0])
        n_arr[num.index(tar)] = 1
        result_list.append(n_arr)
        
    return np.array(result_list), num

one_hot, class_list = onehot_encode(target)
print(one_hot)
print(class_list)

def onehot_decode(one_hot, class_list):
    result_list = []
    for tar in one_hot:
        tar_index = tar.argmax()
        result_list.append(class_list[tar_index])
    return result_list

data = onehot_decode(one_hot, class_list)
print(data)


# encoding = np.eye(num)[target]
# print(encoding)