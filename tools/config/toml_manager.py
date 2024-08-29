import os
import tomllib

from typing import Any

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
PROJECT_DIR = os.path.realpath(f"{SCRIPT_DIR}/../..")

TEMPLATE_PATH="tools/config/template.toml"
CONFIG_PATH = "config.toml"

class Config():
    def __init__(self) -> None:
        with open(f"{PROJECT_DIR}/{TEMPLATE_PATH}", "rb") as toml:
            self.data = tomllib.load(toml)
    
    def get_param(self, path: str) -> Any:
        keys = path.split(":")
        node = self.data

        for key in keys:
            if isinstance(node, dict) and key in node:
                node = node[key]
            else:
                return None  # Path is invalid
        
        return node
