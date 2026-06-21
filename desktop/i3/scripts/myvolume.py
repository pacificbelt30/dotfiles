# get volume
# unsupported getting mute state
import subprocess

def volumebar(volume:int):
    bar = "["
    for i in range(int(volume%101/10)):
        bar += "■"
    for i in range(10-int(volume%101/10)):
        bar += " "
    return bar+" ]"

def get_volume():
    import re
    command = 'amixer -D pulse get Master | grep "^.*\[[0-9]+%\].*$"'
    process = subprocess.run(command.split(" "), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    volume = re.search(r'\[([0-9]+)%\]',process.stdout.decode('utf-8').replace("\n","")).group(1)
    return int(volume)


#音量を片耳からしか取ってない
if __name__ == '__main__':
    volume = get_volume()
    print(volumebar(volume)+ " " +str(volume)+"%")
