from . import socketio
from flask_socketio import emit
import numpy as np
import whisper
import torch


audio_model = whisper.load_model("base")

def register_socket_events():
    @socketio.on('audio')
    def handle_audio(data):
        try:
            # Convert buffer to numpy array and normalize
            audio_np = np.frombuffer(data['audio'], dtype=np.int16).astype(np.float32) / 32768.0
            # Transcribe audio
            result = audio_model.transcribe(audio_np, fp16=torch.cuda.is_available())
            text = result['text'].strip()
            print(f"Transcription: {text}")
            emit('transcription', {'text': text})
        except Exception as e:
            print(f"Error in transcription: {e}")
            emit('error', {'message': str(e)})
