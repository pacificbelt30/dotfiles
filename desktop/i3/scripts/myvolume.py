# get volume
# unsupported getting mute state
import re
import subprocess


def volumebar(volume: int):
    bar = "["
    for _ in range(int(volume % 101 / 10)):
        bar += "■"
    for _ in range(10 - int(volume % 101 / 10)):
        bar += " "
    return bar + " ]"


def get_volume():
    process = subprocess.run(
        ["amixer", "-D", "pulse", "get", "Master"],
        check=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )
    match = re.search(r"\[([0-9]+)%\]", process.stdout)
    if match is None:
        raise RuntimeError("volume percentage was not found in amixer output")
    volume = match.group(1)
    return int(volume)


# 音量を片耳からしか取ってない
if __name__ == "__main__":
    volume = get_volume()
    print(volumebar(volume) + " " + str(volume) + "%")
