import yaml
from datetime import datetime

class bcolors:
    BLUE = '\033[94m'
    CYAN = '\033[96m'
    YELLOW = '\033[93m'
    GREEN = '\033[92m'
    PINK = '\033[95m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


class PeopleDB():
    def __init__(self, yaml_file):
        self.yaml_file = yaml_file
        with open(yaml_file) as file:
            self.db = yaml.load(file, Loader=yaml.FullLoader) # FullLoader converts yaml scalar values to Python dictionaries

    def print(self):
        print(self.db)
