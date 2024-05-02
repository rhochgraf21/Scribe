from . import socketio
from flask_socketio import emit
import numpy as np
import whisper
import torch
import os 


audio_model = whisper.load_model("base")

def register_socket_events():
    @socketio.on('audio')
    def handle_audio(data):
        audio_np = np.frombuffer(data['audio'], dtype=np.int16).astype(np.float32) / 32768.0
        result = audio_model.transcribe(audio_np, fp16=torch.cuda.is_available())
        text = result['text'].strip()
        emit('transcription', {'text': text})
