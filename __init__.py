from flask import Flask
from flask_swagger_ui import get_swaggerui_blueprint
from src.interfaces.http.mainPage import api_mainPage

SWAGGER_URL = "/docs"
API_URL = "/static/swagger.yml"


swaggerui_blueprint = get_swaggerui_blueprint(
    SWAGGER_URL, API_URL, config={"app_name": "IPAPI"}
)


def create_app():
    app = Flask(__name__)
    app.register_blueprint(swaggerui_blueprint, url_prefix=SWAGGER_URL)
    app.register_blueprint(api_mainPage)

    return app
