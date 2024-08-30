import os
import sys

import threading
dummy_event = threading.Event()


SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
PROJECT_DIR = os.path.realpath(f"{SCRIPT_DIR}/../..")

sys.path.append(f"{PROJECT_DIR}/scripts/config")

import re
import subprocess
from typing import List
from enum import Enum
from dataclasses import dataclass

from toml_manager import Config 



@dataclass
class X11Display():
    name: str = "Dummy"
    max_width: int = 0
    max_height: int = 0
    max_pixel_count: int = 0


X11_NAME_RE = re.compile(r"^(?P<name>\S+) connected.*$")
X11_RES_RE = re.compile(r"^\s+(?P<resolution>\d+x\d+)\s+.*$")

def err_assert(msg: str) -> None:
    print(msg)
    assert(True)

def parse_xrandr_output() -> List[X11Display]:
    try:
        result = subprocess.run(
            ['xrandr'], stdout=subprocess.PIPE,
            stderr=subprocess.PIPE, text=True
        )
        xrandr_output = result.stdout
    except Exception as e:
        err_assert(f"Error running xrandr: {e}")
        return

    outputs = []
    new_found = False

    for line in xrandr_output.splitlines():
        name_match = X11_NAME_RE.match(line)
        if name_match:
            output = X11Display()
            output.name = str(name_match.group("name"))
            new_found = True
            continue

        if new_found:
            res_match = X11_RES_RE.match(line)
            if res_match:
                split = res_match.group("resolution").split("x")
                output.max_width = int(split[0])
                output.max_height = int(split[1])
                output.max_pixel_count = output.max_height * output.max_width
                outputs.append(output)
                output = X11Display()
                new_found = False
    
    return outputs


def xrandr_set_monitor(name: str, outputs: List[X11Display]) -> None:
    cmd = f"xrandr --output {name} --auto"
    for output in outputs:
        if output.name != name:
            cmd = f"{cmd} --output {output.name} --off"
    os.system(cmd)
    reload_feh_wallpaper()


def reload_feh_wallpaper() -> None:
    os.system("pkill feh && feh -F --bg-scale ~/.config/eww/background.jpg")

def main() -> None:
    conf = Config()

    current_display = X11Display()
    next_display = X11Display()
    max_height_display = X11Display()
    max_width_display = X11Display()
    max_pixel_count_display = X11Display()

    while True:
        dummy_event.wait(1) 
        priority = conf.get_param("x11:monitors:priority")
        parsed_outputs = parse_xrandr_output()

        for output in parsed_outputs:
            if output.max_width > max_width_display.max_width:
                max_width_display = output
            if output.max_height > max_height_display.max_height:
                max_height_display = output
            if output.max_pixel_count > max_pixel_count_display.max_pixel_count:
                max_pixel_count_display = output 
        match priority:
            case "width":
                next_display = max_width_display
            case "height":
                next_display = max_height_display
            case "pixel_count":
                next_display = max_pixel_count_display
            case _:
                next_display = max_width_display

        if current_display != next_display:
            current_display = next_display
            xrandr_set_monitor(current_display.name, parsed_outputs)
            os.system(f'echo {current_display.name}')

        

if __name__ == "__main__":
    main()
