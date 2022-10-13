#!/usr/bin/env python3
import pathlib
import platform
import time
import webbrowser

FACTORIO_VERSION = "stable"  # TODO: config


def download_dir():
    plat = platform.system()
    if plat == 'Linux':
        return pathlib.Path.home() / 'Downloads'
    elif plat == 'Windows':
        raise NotImplementedError("haven't done windows yet")
    elif plat == 'Darwin':
        raise NotImplementedError("haven't done mac yet")
    else:
        raise NotImplementedError(f"Unknown platform {plat!r}")


webbrowser.open(f"https://www.factorio.com/get-download/{FACTORIO_VERSION}/alpha/linux64")

dl = download_dir()

files = None
while not files:
    time.sleep(1)
    files = dl.glob("factorio_alpha_x64_*.tar.xz")

files[0].rename('./factorio.tar.xz')
