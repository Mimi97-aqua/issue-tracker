'''
Health Route
'''

from flask import Blueprint, redirect, url_for, jsonify

index = Blueprint('index', __name__)


@index.route('/greet', methods=['GET'])
def welcome():
    return jsonify({
        'status': 'success',
        'message': url_for('api.auth.login', _external=True)
    }), 200


@index.route('/', methods=['GET'])
def health():
    '''
    Health check
    '''
    return redirect(url_for('.welcome'))
