from flask import Blueprint

from .auth import auth

api = Blueprint('api', __name__, url_prefix='/api/issue-tracker')

api.register_blueprint(auth, url_prefix='/auth')
