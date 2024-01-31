FROM python:3.11-slim

ENV PYTHONUNBUFFERED True

WORKDIR /tmp

RUN apt-get update
RUN apt-get -y install wget dpkg
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

RUN apt-get -y install fonts-ipafont-gothic fonts-ipafont-mincho

#App
RUN mkdir /usr/src/app/
COPY requirements.txt /usr/src/app/
COPY screenshot.py /usr/src/app/
WORKDIR /usr/src/app/
RUN pip install -r requirements.txt

CMD ["python", "screenshot.py"]