FROM python:3.7.3-stretch

WORKDIR /tmp

COPY . /tmp/

RUN pip install --upgrade pip &&\
    pip install pylint &&\
    pip install -r app/requirements.txt
