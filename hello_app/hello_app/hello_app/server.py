# -*- coding:utf8 -*-
# !/usr/bin/env python
import logging

import cow
from flask import Flask

app = Flask(__name__)

logger = cow.LogBuilder()
logger.add_stream_handler(level=logging.DEBUG)
logger.build()
logging.info("Start {}".format("w3tools"))
logging.error("test log")



@app.route("/hello")
def hello():
    return "hello"


@app.route("/")
def index():
    return "<h1>hello</h1>"


if __name__ == '__main__':
    port = 14000
    logging.debug("Starting app on port %d" % port)
    app.config['TEMPLATES_AUTO_RELOAD'] = True
    app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0
    app.run(debug=False, port=port, host='0.0.0.0', threaded=True)
