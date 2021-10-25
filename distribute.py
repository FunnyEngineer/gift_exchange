import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import random

cred = credentials.Certificate(
    "gift-exchange-9c3cd-firebase-adminsdk-kfpb1-3f4c8e300a.json")
firebase_admin.initialize_app(cred)


db = firestore.client()
data = []
num = len(db.collection('gifts').get())
sim_list = list(range(num))
print(sim_list)
check = False
while check == False:
    random.shuffle(sim_list)
    for i in range(len(sim_list)):
        if i == sim_list[i]:
            check = False
            print(sim_list)
            print('{} 拿到自己的禮物了'.format(i))
            break
        check = True
print('檢查完畢')

# collect data
for i, doc in enumerate(db.collection('gifts').get()):
    sin_data = doc.get('')
    data.append(
        {
            'r_student_ID': sin_data['student_ID'],
            'r_file_ID': sin_data['file_ID'],
            'r_file_type': sin_data['file_type'],
            'received': True
        }
    )

# set data()
for i, doc in enumerate(db.collection('gifts').list_documents()):
    sin_data = doc.update(data[sim_list[i]])
