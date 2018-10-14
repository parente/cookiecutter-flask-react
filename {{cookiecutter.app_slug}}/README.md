# {{ cookiecutter.app_name }}

{{ cookiecutter.app_description }}

Build Docker images with Python and JavaScript dev/test requirements installed.

```bash
make jsdev-image
make pydev-image
```

Set the Parcel builder to watch for JavaScript code changes and compile a dev
`index.js`. Run a Flask server that loads the `index.js` and autoreloads on
Python changes.

```
# In two separate terminals ...
make parcel
make flask
```

Run pytest unit tests. Watch JavaScript files and run Jest tests.

```bash
make pytest
make jstest-watch
```

Build a local production image with Gunicorn and minified JS. Scale three
instances of the web app using Docker Compose.

```bash
make stack
make unstack
```

Deploy to a Docker service provider (e.g., ZEIT).

```bash
now --docker --public
now ls
now scale <url> 0 3
```