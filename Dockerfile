FROM python:3-alpine as base

# Make application directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Add Python requirements
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache -r /usr/src/app/requirements.txt

############# Python development build stage

FROM base as pydev

# Add Python development requirements
COPY requirements-test.txt /usr/src/app/
RUN pip install --no-cache -r /usr/src/app/requirements-test.txt

############# JavaScript development build stage

FROM node:10-alpine as jsdev

# Make application directory (for consistency)
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Add JS requirements separately so that we don't need to reinstall every
# time something in the source tree changes on the host
COPY package.json /usr/src/app
RUN cd /usr/src/app && \
    npm install .

############# JavaScript minification build stage

FROM jsdev as builder

# Add JS source
COPY ./example_app/static /usr/src/app/example_app/static
# Build production JS assets
RUN npm run build

############# Production stage

FROM base as production

# Add app source
COPY ./example_app /usr/src/app/example_app
# Add built production JS assets
COPY --from=builder /usr/src/app/example_app/static/dist /usr/src/app/example_app/static/dist

ENV WEB_CONCURRENCY 1
WORKDIR /usr/src/app
EXPOSE 8080
USER nobody
CMD ["gunicorn", "-b", "0.0.0.0:8080", "--access-logfile", "-", "example_app:app"]