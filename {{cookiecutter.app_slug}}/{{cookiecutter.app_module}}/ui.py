from flask import Blueprint, render_template

blueprint = Blueprint('ui', __name__, static_folder='static')


@blueprint.route('/', methods=['GET'])
def index():
    """Renders the main application template.

    Returns
    -------
    str
        Rendered index page
    """
    return render_template('index.html')
