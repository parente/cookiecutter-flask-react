[![Build Status](https://travis-ci.com/parente/cookiecutter-flask-react.svg?branch=master)](https://travis-ci.com/parente/cookiecutter-flask-react)

# cookiecutter-flask-react

Running:

```
cookiecutter https://github.com/parente/cookiecutter-flask-react.git
```

gives you a local project folder with an example echo application ready for
development and testing with:

* [Flask](http://flask.pocoo.org/) on [Python 3](https://python.org) as the web backend
* [React](https://reactjs.org/) with [Bootstrap](http://getbootstrap.com/) as the web frontend
* [Parcel](https://parceljs.org/) for watching, building, and minifying web assets
* [pytest](https://docs.pytest.org/en/latest/) for running Python tests
* [Jest](https://jestjs.io/) for running JavaScript tests
* [Docker](https://www.docker.com/) image definitions based on [Alpine](https://alpinelinux.org/) for development and production
* [Make](https://www.gnu.org/software/make/) targets for convenient control of all of the above
* [Travis CI](http://travis-ci.org) config for continuous integration
