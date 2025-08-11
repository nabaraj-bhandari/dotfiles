from flask import Flask, request
from flask_cors import CORS
import subprocess
import os

app = Flask(__name__)
CORS(app)  # Enables CORS for all routes

@app.route('/download')
def download():
    url = request.args.get('url')
    dtype = request.args.get('type')

    if not url or dtype not in ['video', 'audio']:
        return "Bad Request", 400

    if dtype == 'video':
        outdir = os.path.expanduser('~/Videos')
        cmd = [
            'yt-dlp', '-f', 'bestvideo[height<=720]+bestaudio/best[height<=720]', '--restrict-filenames',
            '-o', os.path.join(outdir, '%(title)s.%(ext)s'),
            url
        ]
    else:
        outdir = os.path.expanduser('~/Music')
        cmd = [
            'yt-dlp', '--extract-audio', '--audio-format', 'mp3',
            '-o', os.path.join(outdir, '%(title)s.%(ext)s'),
            url
        ]

    subprocess.Popen(cmd)
    return "Started download"

if __name__ == '__main__':
    app.run(port=5000)

