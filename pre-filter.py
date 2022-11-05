#!/usr/bin/env python3
"""
Filter an AMP dump before we do anything with it.
"""
import argparse
import json
import pathlib


parser = argparse.ArgumentParser()
parser.add_argument('--mods', type=pathlib.Path)
args = parser.parse_args()


# Strip Pause Instead of Catching Up

for piocu in args.mods.glob("piocu-pause-instead-of-catching-up_*.zip"):
    piocu.unlink()

modlist = json.loads((args.mods / 'mod-list.json').read_text())
for mod in modlist['mods']:
    if mod["name"] == "piocu-pause-instead-of-catching-up":
        mod["enabled"] = False
(args.mods / 'mod-list.json').write_text(json.dumps(modlist))
