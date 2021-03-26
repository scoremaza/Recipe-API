FROM python:3.7-alpine
LABEL maintainer="En-lightenE"
# Here we have buffer mode set to 1 to run unbuffered 
# The reason for this is that it doesn't allow Python to buffer the outputs
ENV PYTHONUNBUFFERED 1 
# Here we have the directory adjacent to the doc a file copy of the requirements
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps
# Here we have the command to make the app directory 
RUN mkdir /app
# Here we have the directive to assign the work directory to app
WORKDIR /app
# Here we have the assigning a copy the directory app to a another directory called app in docker image
COPY ./app /app

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
RUN adduser -D user
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
USER user

