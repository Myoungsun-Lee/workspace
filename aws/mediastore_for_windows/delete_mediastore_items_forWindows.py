import json
import subprocess

### main live_mediastore_container
#_endpoint = 'https://phzcb7ahdbgkuf.data.mediastore.ap-northeast-2.amazonaws.com'

### sub test_mediastore_container
_endpoint = 'https://scnzdcurnikmwa.data.mediastore.ap-northeast-2.amazonaws.com'

_path = '/live_0531_sub/'

cmd='aws mediastore-data --region ap-northeast-2 list-items --endpoint='+ _endpoint +' --path='+ _path +' > list.log'
print('Making a list')
res = subprocess.call(cmd, shell=True)
print('Complted to make the list.\nStart deleting...')


with open('./list.log') as json_file:
    json_data = json.load(json_file)
    for filename in json_data['Items']:
        cmd='aws mediastore-data --region ap-northeast-2 delete-object --endpoint='+ _endpoint +' --path='+ _path + filename['Name']
        #print(cmd)
        res = subprocess.call(cmd, shell=True)
        if res == 0 :
            print('Delete Completed: ', filename['Name'])