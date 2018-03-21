- [Introduction](#introduction)
- [Files](#files)
- [Making image](#making-image)

# Introduction
This image is useful if you use Ruby on Rails applications.

Also you can use entrypoint / Dockerfile for your applications.

Simplest way - adding dockerfile / entrypoint to your git repository.
# Files 
## Dockerfile
```
FROM esementsov/ruby-passenger-alpine:2.4.1

RUN mkdir /myapp
WORKDIR /myapp

# add your application code to image
COPY . /myapp
RUN rm -rf /myapp/.git
RUN chmod u+x /myapp/entrypoint.sh

RUN ${RBENV_ROOT}/shims/bundle install --without development test

EXPOSE 80

ENTRYPOINT ["/myapp/entrypoint.sh"]
```
## entrypoint.sh
```
#!/bin/bash

${RBENV_ROOT}/shims/bundle exec rake assets:clobber && \
${RBENV_ROOT}/shims/bundle exec rake assets:precompile && \
${RBENV_ROOT}/shims/bundle exec rake db:migrate && \
/usr/local/rbenv/shims/passenger start -p 80 -e production --log-level 4
```
# Making image
```
docker build -t myapp:1.0 .
```