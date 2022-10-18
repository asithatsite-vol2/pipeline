import itertools
import subprocess

from flask import Flask, request


app = Flask(__name__)


def accepted():
    return "", 202, {'Content-Type': 'text/plain'}


def kick_off_run(environ):
    """
    Kicks off a cirrus pipeline execution
    """
    envargs = itertools.chain.from_iterable(
        ('-e', f"{key}={value}")
        for key, value in environ.items()        
    )
    subprocess.Popen(
        ['cirrus', 'run', '--dirty', *envargs],
        stdin=subprocess.DEVNULL, stderr=subprocess.STDOUT,
        # TODO: Dump the logs somewhere
    )


@app.route("/<str:key>/incoming/<str:event>", methods=['POST'])
def event_hook(key, event):
    """
    Take in an event from AMP and trigger a local Cirrus pipeline
    """
    # TODO: Validate key
    # FIXME: Run queue
    kick_off_run(request.form)  # TODO: Support JSON?
    return accepted()
