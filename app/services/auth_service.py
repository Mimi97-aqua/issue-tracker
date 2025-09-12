'''
Auth Service
- Login
- Logout
- Password Reset
'''
from flask import request, jsonify
from flask_jwt_extended import create_access_token, create_refresh_token, jwt_required, get_jwt_identity, get_jwt

from ..utils.db_conn import get_db

from datetime import timedelta


def login(email, password):
    '''
    Login:
        - Verifies credentials exist in db
        - Creates access token and refresh token
    :param email: User email
    :param password: User password
    '''
    try:
        if not email or not password:
            return jsonify({
                'status': 'fail',
                'message': 'Email and password are required'
            }), 400

        with get_db() as conn:
            with conn.cursor() as cursor:
                cursor.execute("""
                               select id,
                                      permission
                               from members
                               where email = %s
                                 and password = crypt(%s, password)
                               """, (email, password))
                member = cursor.fetchone()

                if member:
                    id = member[0]
                    permission = member[1]

                    access_token = create_access_token(
                        identity=str(id),
                        additional_claims={'permission': permission}
                    )
                    refresh_token = create_refresh_token(
                        identity=str(id),
                        additional_claims={'permission': permission}
                    )

                    return jsonify({
                        'status': 'success',
                        'message': 'Login Successful',
                        'access_token': access_token,
                        'refresh_token': refresh_token,
                        'token_type': 'bearer',
                        'expires_in': timedelta(minutes=60),
                        'user_id': id,
                        'permission': permission
                    }), 200
                else:
                    return jsonify({
                        'status': 'fail',
                        'message': 'Invalid email or password.'
                    }), 400
    except Exception as e:
        return jsonify({
            'status': 'fail',
            'message': str(e)
        }), 500
