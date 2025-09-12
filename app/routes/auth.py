'''
Auth Endpoints
'''
from flask import Blueprint, request, jsonify

from ..services import auth_service

auth = Blueprint('auth', __name__)


@auth.route('/login', methods=['POST'])
def login():
    '''
    Login View Function
    :return:
    '''
    email = request.form.get('email')
    password = request.form.get('password')

    return auth_service.login(email, password)
