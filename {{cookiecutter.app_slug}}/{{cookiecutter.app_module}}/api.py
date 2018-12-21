import datetime
import json
import os

from flask import Blueprint, jsonify

blueprint = Blueprint('api', __name__)


class APIError(Exception):
    """Represents an API error.

    Follows the API exception raising and handling pattern documented
    at http://flask.pocoo.org/docs/0.12/patterns/apierrors/
    """
    def __init__(self, status_code, payload):
        super(APIError, self).__init__(self)
        self.status_code = status_code
        self.payload = payload


@blueprint.errorhandler(APIError)
def handle_api_error(error):
    """Responds with an API error in JSON format.

    Parameters
    ----------
    error: APIError

    Returns
    -------
    dict
    """
    response = jsonify(error.payload)
    response.status_code = error.status_code
    return response


@blueprint.route('/api/echo/<value>', methods=['GET'])
def echo(value):
    return jsonify({'value': value})
