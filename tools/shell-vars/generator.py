import os
import sys

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
PROJECT_DIR = os.path.realpath(f"{SCRIPT_DIR}/../..")
OUTPUT_DIR = f"{SCRIPT_DIR}/autogen"

sys.path.append(f"{PROJECT_DIR}/tools/config")

from abc import ABC, abstractmethod
from typing import NamedTuple
from enum import Enum

from toml_manager import Config
import inspect


class ShellUse(Enum):
    VARIABLE = 0
    ALIAS = 1
    FUNCTION = 2

class Shell(Enum):
    FISH = 0
    BASH = 1

class ShellStatement(NamedTuple):
    name: str
    value: str
    use: ShellUse

def assert_err(msg: str) -> None:
    print(msg)
    assert(True)

class StatementTranslator(ABC):

    def translate(self, stm: ShellStatement) -> str:
        match stm.use:
            case ShellUse.ALIAS:
                return self.translate_alias(stm)
            case ShellUse.VARIABLE:
                return self.translate_variable(stm)
            case ShellUse.FUNCTION:
                return self.translate_function(stm)
            case _:
                assert_err("Assert: Unexpected type")

    @abstractmethod
    def translate_alias(self, stm: ShellStatement) -> str:
        ...
    
    @abstractmethod
    def translate_variable(self, stm: ShellStatement) -> str:
        ...
    
    @abstractmethod
    def translate_function(self, stm: ShellStatement) -> str:
        ...
    
    @abstractmethod
    def config_file_name(self) -> str:
        ...

SHELL_ALIASES = [
    ShellStatement("g", "git", ShellUse.ALIAS),
    ShellStatement("g-a", "git add", ShellUse.ALIAS),
    ShellStatement("g-au", "git add --update", ShellUse.ALIAS),
    
    ShellStatement("g-br", "git branch", ShellUse.ALIAS),
    ShellStatement("g-br-del", "git branch --delete", ShellUse.ALIAS),
    ShellStatement("g-br-delf", "git branch --delete --force", ShellUse.ALIAS),
    
    ShellStatement("g-clean", "git clean", ShellUse.ALIAS),
    ShellStatement("g-clean-fdx", "git clean -dx --force", ShellUse.ALIAS),
    
    ShellStatement("g-clone", "git clone", ShellUse.ALIAS),
    
    ShellStatement("g-cm-e", "git commit", ShellUse.ALIAS),
    ShellStatement("g-cm", "git commit -m", ShellUse.ALIAS),
    ShellStatement("g-am-e", "git commit --amend", ShellUse.ALIAS),
    ShellStatement("g-am", "git commit --amend --no-edit", ShellUse.ALIAS),

    ShellStatement("g-conf", "git config", ShellUse.ALIAS),
    ShellStatement("g-conf-glob", "git config --global", ShellUse.ALIAS),
    
    ShellStatement("g-df", "git diff", ShellUse.ALIAS),

    ShellStatement("g-fetch", "git fetch", ShellUse.ALIAS),

    ShellStatement("g-init", "git init", ShellUse.ALIAS),

    ShellStatement("g-merg", "git merge", ShellUse.ALIAS),
    ShellStatement("g-merg-con", "git merge --continue", ShellUse.ALIAS),
    ShellStatement("g-merg-abo", "git merge --abort", ShellUse.ALIAS),

    ShellStatement("g-pull", "git pull", ShellUse.ALIAS),
    ShellStatement("g-pull-f", "git pull --force", ShellUse.ALIAS),

    ShellStatement("g-push", "git push", ShellUse.ALIAS),
    ShellStatement("g-push-f", "git push --force", ShellUse.ALIAS),
    
    ShellStatement("g-reb", "git rebase", ShellUse.ALIAS),
    ShellStatement("g-reb-i", "git rebase --interactive", ShellUse.ALIAS),
    ShellStatement("g-reb-abo", "git rebase --abort", ShellUse.ALIAS),
    ShellStatement("g-reb-skip", "git reabse --skip", ShellUse.ALIAS),
    ShellStatement("g-reb-con", "git reabse --continue", ShellUse.ALIAS),

    ShellStatement("g-reset", "git reset", ShellUse.ALIAS),
    ShellStatement("g-reset-s", "git reset --soft", ShellUse.ALIAS),
    ShellStatement("g-reset-h", "git reset --hard", ShellUse.ALIAS),

    ShellStatement("g-rest", "git restore", ShellUse.ALIAS),
    ShellStatement("g-rest-st", "git restore --staged", ShellUse.ALIAS),
    
    ShellStatement("g-sw", "git switch", ShellUse.ALIAS),
    
    ShellStatement("g-stash", "git stash", ShellUse.ALIAS),
    ShellStatement("g-stash-p", "git stash pop", ShellUse.ALIAS),

    ShellStatement("g-st", "git status -uno", ShellUse.ALIAS),
    ShellStatement("g-st-a", "git status", ShellUse.ALIAS)
]


SHELL_VARIABLES = [

]

SHELL_FUNCTIONS = [

]
INDENT_LENGTH = 4
INDENT = " " * INDENT_LENGTH

class FishTranslator(StatementTranslator):
    def translate_alias(self, stm: ShellStatement) -> str:
        return f'alias {stm.name}="{stm.value}"'
    
    def translate_variable(self, stm: ShellStatement) -> str:
        return f'set -Ux {stm.name} "{stm.value}"'
    
    def translate_function(self, stm: ShellStatement) -> str:
        line_list = stm.value.split('\n')
        indented = []
        for line in line_list:
            indented.append(f"{INDENT}{line}")
        joined = '\n'.join(indented)
        return f"function {stm.name}\n{joined}\nend"
    
    def config_file_name(self) -> str:
        return "config.fish"


class BashTranslator(StatementTranslator):
    def translate_alias(self, stm: ShellStatement) -> str:
        return f'alias {stm.name}="{stm.value}"'
    
    def translate_variable(self, stm: ShellStatement) -> str:
        return f'{stm.name}="{stm.value}"'
    
    def translate_function(self, stm: ShellStatement) -> str:
        line_list = stm.value.split('\n')
        indented = []
        for line in line_list:
            indented.append(f"{INDENT}{line}")
        joined = '\n'.join(indented)
        return f"function {stm.name} {"{"}\n{joined}\n{"}"}"
    
    def config_file_name(self) -> str:
        return "bashrc"


def generate_shell_config(translator: StatementTranslator) -> None:
    conf = Config()

    output = []

    output.append("### ALIASES ###")
    if(conf.get_param("shell:aliases:use_default")):
        for statement in SHELL_ALIASES:
            output.append(translator.translate(statement))
    
    for alias in conf.get_param("shell:aliases:custom"):
        output.append(translator.translate(
            ShellStatement(alias[0], alias[1], ShellUse.ALIAS))
        )
    output.append("\n")

    output.append("### VARIABLES ###")
    if(conf.get_param("shell:variables:use_default")):
        for statement in SHELL_VARIABLES:
            output.append(translator.translate(statement))
    
    for var in conf.get_param("shell:variables:custom"):
        output.append(translator.translate(
            ShellStatement(var[0], var[1], ShellUse.VARIABLE))
        )
    output.append("\n")

    output.append("### FUNCTIONS ###")
    if(conf.get_param("shell:functions:use_default")):
        for statement in SHELL_FUNCTIONS:
            output.append(translator.translate(statement))
    
    for func in conf.get_param("shell:functions:custom"):
        output.append(translator.translate(
            ShellStatement(func[0], inspect.cleandoc(func[1]), ShellUse.FUNCTION))
        )
    output.append("\n")
    
    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)
    
    with open(f"{OUTPUT_DIR}/{translator.config_file_name()}", "w") as autogen:
        autogen.write("\n".join(output))
 

def generate_all_configs() -> None:
    generate_shell_config(FishTranslator())
    generate_shell_config(BashTranslator())

generate_all_configs()
