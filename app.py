from flask import Flask
from redis import Redis, RedisError
import datetime
import os
import socket

# Connect to Redis
redis = Redis(host="redis", db=0, socket_connect_timeout=2, socket_timeout=2)

app = Flask(__name__)

@app.route("/")
def hello():
    try:
        visits = redis.incr("counter")
    except RedisError:
        visits = "<i>cannot connect to Redis, counter disabled</i>"
    # get current date time
    now = datetime.datetime.now()

    html = "<h3>Hello {name} !</h3>" \
           "<b>Docker Hostname:</b> {hostname}<br/>" \
           "<b>Visits counter:</b> {visits}<br/>" \
           "<b>Date:</b> {now}"
    return html.format(name=os.getenv("NAME", "world"), hostname=socket.gethostname(), visits=visits, now=now)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
