#!/usr/bin/sh
if [ -z "$1" ]; then
    gamefile=$(find /opt/factorio/saves /opt/factorio/config/saves -type f -exec stat -c '%X %n' {} \; | sort -nr | head -n 1 | cut -d ' ' -f 2)
    echo Using game file $gamefile
    exec mapshot --logtostderr --factorio_verbose render "$gamefile"
else
    exec mapshot --logtostderr --factorio_verbose render "$@"
fi