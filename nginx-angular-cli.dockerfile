FROM nginx:1.15

VOLUME [ "/usr/share/nginx/www" ]

# Update distros & install build essentials
RUN apt-get update
RUN apt-get install apt-transport-https gnupg2 curl tree -y

# Setup Node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# Check node version
RUN echo "NPM & Node version? [$(npm --version)] & [$(node --version)]"

# Setup Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install --no-install-recommends -y yarn
# RUN apt-get install -y yarn

# Check yarn version
RUN echo "Yarn version: $(yarn --version)"

# Prepare for build
ENV WORKDIR /opt/app
ENV APPDIR ${WORKDIR}/dist/www
ADD ./ ${WORKDIR}/

WORKDIR ${WORKDIR}
RUN tree -L 2 .

# install angular cli
RUN npm i -g @angular/cli

# check angular version
RUN ng --version

# EXAMPLE: Building your angular project
#
# # Building project
RUN cd ${WORKDIR} && yarn install
RUN cd ${WORKDIR} && yarn build

# Prepare static files to be hosted
RUN chmod -R a+r ${APPDIR}

# Copy the nginx configuration file. This sets up the behavior of nginx, most
# importantly, it ensure nginx listens on port 8080. Google App Engine expects
# the runtime to respond to HTTP requests at port 8080.
COPY nginx.conf /etc/nginx/nginx.conf

# create log dir configured in nginx.conf
RUN mkdir -p /var/log/app_engine

# Create a simple file to handle heath checks. Health checking can be disabled
# in app.yaml, but is highly recommended. Google App Engine will send an HTTP
# request to /_ah/health and any 2xx or 404 response is considered healthy.
# Because 404 responses are considered healthy, this could actually be left
# out as nginx will return 404 if the file isn't found. However, it is better
# to be explicit.
RUN mkdir -p ${APPDIR}/_ah && \
  echo "healthy" > ${APPDIR}/_ah/health

# @TODO Cleanup ${WORKDIR}/node_modules

# Finally, all static assets.
# ADD dist/www/ /usr/share/nginx/www/
# RUN chmod -R a+r /usr/share/nginx/www
