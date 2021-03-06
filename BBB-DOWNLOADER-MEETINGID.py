#!/usr/bin/env python3

from sys import argv
from pathlib import Path

start = 'meetingId='
end = '"fin'

for path in argv[1:]:
    text = Path(path).read_text()
    print(text[text.find(start) + len(start) : text.find(end)])