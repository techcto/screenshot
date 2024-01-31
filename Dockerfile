FROM python:3.11-slim

ENV PYTHONUNBUFFERED True

WORKDIR /tmp

ARG CHROME_VERSION=114.0.5735.91
ARG CHROME_DRIVER_VERSION=114.0.5735.90

RUN apt-get update
RUN apt-get -y install wget dpkg
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install
# RUN wget https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}_amd64.deb
# RUN dpkg -i google-chrome-stable_${CHROME_VERSION}_amd64.deb; apt-get -fy install

# Install chromedriver
# RUN apt-get update && apt-get install -y \
#     unzip \
# 	&& wget https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip \
# 	&& unzip chromedriver_linux64.zip \
# 	&& mv chromedriver /usr/local/bin/ \
# 	&& rm chromedriver_linux64.zip

RUN apt-get -y install fonts-ipafont-gothic fonts-ipafont-mincho

#App
RUN mkdir /usr/src/app/
COPY requirements.txt /usr/src/app/
COPY screenshot.py /usr/src/app/
WORKDIR /usr/src/app/
RUN pip install -r requirements.txt

CMD ["python", "screenshot.py"]
