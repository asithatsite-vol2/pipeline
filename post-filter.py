#!/usr/bin/python3
"""
Removes unnecessary surfaces from a mapshot run.
"""
import json
import pathlib
import re
import shutil
import sys

#: regexes for surfaces to remove
EXCLUSION_PATTERNS = list(map(re.compile, [
    r'starmap-\d+',
    r'Vault [.0-9]+',
    r'aai-signals',
    r'starship-\d+'
]))


class MapshotOutput:
    def __init__(self, root):
        self.root = pathlib.Path(root)
        try:
            self.metafile = list(self.root.glob("*/mapshot.json"))[0]
        except IndexError as exc:
            raise ValueError(
                f"Root {root!r} does not appear to be mapshot output; missing 'mapshot.json'"
            ) from exc

        self.data_root = self.metafile.parent
        self.metadta = json.loads(self.metafile.read_text())

    def surface_dirs(self, prefix):
        """
        Yields all the directories for the given surface prefix.
        """
        yield from self.data_root.glob(f'{prefix}*')

    def filter_surfaces(self, predicate):
        """
        Destructively removes surface data.

        predicate: what surfaces to keep.
        """
        to_remove = [surface for surface in self.metadata['surfaces'] if not predicate(surface)]

        for surface in to_remove:
            for path in self.surface_dirs(surface['file_prefix']):
                shutil.rmtree(path)

        self.metadata['surfaces'] = [surface for surface in self.metadata['surfaces'] if predicate(surface)]


# FIXME: argparse
mapshot = MapshotOutput(sys.argv[1])
