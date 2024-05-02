from flask import Flask
from flask_socketio import SocketIO

socketio = SocketIO()

app = Flask(__name__)

socketio.init_app(app)

from app.routes import main as main_blueprint
from app import events

app.register_blueprint(main_blueprint)