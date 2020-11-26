#Recently, we can delete items in MediaStore Containers.
#But it is hard to delete one by one.
#This code will delete specific object what you want.
#It is useful, if you have many objects in one container and you want to delete one of them.

import json
import subprocess

_endpoint = 'Enter Your MediaStore Endpoint URL'
#You have to write '/' for _path (e.g. /awstest/ )
_path = '/Enter Your Path/'

cmd='aws mediastore-data --region ap-northeast-2 list-items --endpoint='+ _endpoint +' --path='+ _path +' > list.log'
print('Making a list')
subprocess.call(cmd, shell=True)
print('Complted to make the list')

with open('./list.log') as json_file:
    json_data = json.load(json_file)
    for filename in json_data['Items']:
        cmd='aws mediastore-data --region ap-northeast-2 delete-object --endpoint='+ _endpoint +' --path='+ _path + filename['Name']
        #print(cmd)
        res = subprocess.call(cmd, shell=True)
        if res == 0 :
            print('Delete Completed: ', filename['Name'])
    
