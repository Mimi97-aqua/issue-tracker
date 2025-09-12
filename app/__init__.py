'''
Application Factory
'''
import os

from flask import Flask
from flask_jwt_extended import JWTManager
from dotenv import load_dotenv

from datetime import timedelta

from .routes import api
from .routes.index import index

load_dotenv()


def create_app():
    '''
    Application factory
    :return: application instance
    '''
    app = Flask(__name__)

    app.config['JWT_SECRET_KEY'] = os.getenv('JWT_SECRET_KEY')
    app.config['JWT_BLACKLIST_ENABLED'] = os.getenv('JWT_BLACKLIST_ENABLED')
    app.config['JWT_BLACKLIST_TOKEN_CHECKS'] = os.getenv('JWT_BLACKLIST_TOKEN_CHECKS')
    app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(minutes=60)
    app.config['JWT_REFRESH_TOKEN_EXPIRES'] = timedelta(days=7)

    jwt = JWTManager(app)

    # register blueprints
    app.register_blueprint(api)
    app.register_blueprint(index)

    return app
