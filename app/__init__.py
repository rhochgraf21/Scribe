from flask import Flask
from flask_socketio import SocketIO

socketio = SocketIO()

def create_app():
    app = Flask(__name__)
    socketio.init_app(app)

    from .routes import main
    app.register_blueprint(main)

    from .events import register_socket_events
    register_socket_events()

    return app
