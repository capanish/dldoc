FROM ubuntu:18.04
MAINTAINER Anish Kumar <anish.t.kumar@capgemini.com>
# Reference https://www.pyimagesearch.com/2016/10/24/ubuntu-16-04-how-to-install-opencv/

USER root

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install apt-utils
RUN apt-get -y install locales
RUN locale-gen "en_US.UTF-8"
RUN dpkg-reconfigure --frontend=noninteractive locales
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get -y install python3-dev python3 python3-pip python3-venv
RUN pip3 install --upgrade pip

RUN apt-get -y install build-essential cmake pkg-config wget unzip

RUN apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev

RUN apt-get -y install libgtk-3-dev

RUN apt-get -y install libatlas-base-dev gfortran

RUN apt-get install -y curl ca-certificates sudo git bzip2 libx11-6 && rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN pip3 install numpy==1.14.2
RUN pip3 install opencv-python

RUN ldconfig

ADD requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

RUN pip3 install matplotlib
RUN pip3 install xmltodict
RUN pip3 install torchvision

RUN mkdir /playground
COPY notebooks /playground/notebooks

ENV PYTHONPATH /playground
WORKDIR /playground
CMD ["jupyter", "notebook", "--allow-root", "--ip=0.0.0.0", "--NotebookApp.token=", "/playground"]

EXPOSE 8888/tcp
