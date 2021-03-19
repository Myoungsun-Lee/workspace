import os.path
import time
import requests
import subprocess
import threading
from requests.auth import HTTPDigestAuth
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

url="https://b09fbb15f65fe502.mediapackage.ap-northeast-2.amazonaws.com/in/v2/5d6d780663ba467590543650f3cd5352/5d6d780663ba467590543650f3cd5352/"

def upload(fullpath_):
    #print("upload: %s" % fullpath_)
    subprocess.run(["./upload.sh", fullpath_]) 

class Watcher:
    DIRECTORY_TO_WATCH = "/mnt/p/라이브테스트/ffmpeg_abr/"
    #DIRECTORY_TO_WATCH = input("Enter your path: ")

    def __init__(self):
        self.observer = Observer()

    def run(self):
        event_handler = Handler()
        self.observer.schedule(event_handler, self.DIRECTORY_TO_WATCH, recursive=True)
        self.observer.start()
        try:
            while True:
                time.sleep(5)
        except:
            self.observer.stop()
            print("Error")

        self.observer.join()


class Handler(FileSystemEventHandler):

    @staticmethod
    def on_any_event(event):
        if event.is_directory:
            return None

        elif event.event_type == 'created':
            # Take any action here when a file is first created.
            print("Received created event - %s." % event.src_path)            

        elif event.event_type == 'modified':
            # Taken any action here when a file is modified.
            fullpath = "%s" % event.src_path
            print("Received modified event - " + fullpath)
            Fname, Extension = os.path.splitext(os.path.basename(event.src_path))
            if Extension == '.ts':
                #print("upload to aws - " + fullpath)
                #time.sleep(0.05)
                #subprocess.run(["./upload.sh", fullpath.encode()])
                t=threading.Thread(target=upload, args=(fullpath.encode(),))
                t.start()       
                
if __name__ == '__main__':
    w = Watcher()
    w.run()
