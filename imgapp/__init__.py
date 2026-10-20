from io import BytesIO

import requests
from flask import Flask, send_file
from PIL import Image

app = Flask(__name__)


IMAGE_URL = "https://farm1.staticflickr.com/422/32287743652_9f69a6e9d9_b.jpg"
IMAGE_URL = "https://www.python.org/static/img/python-logo.png"
IMAGE_SIZE = (290, 82)


@app.route("/")
def hello():
    return "Hello World!"


@app.route("/image")
def image():
    r = requests.get(IMAGE_URL)
    if not r.status_code == 200:
        raise ValueError(f"Response code was '{r.status_code}'")

    img_io = BytesIO()

    img = Image.open(BytesIO(r.content))
    img.thumbnail(IMAGE_SIZE)
    img.save(img_io, "PNG", quality=70)

    img_io.seek(0)

    return send_file(img_io, mimetype="image/jpeg")


def main():
    app.run()


if __name__ == "__main__":
    main()
