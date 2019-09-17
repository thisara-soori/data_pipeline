ARG BASE_CONTAINER=jupyter/datascience-notebook
FROM $BASE_CONTAINER
MAINTAINER thisarasooriyarachchi@gmail.com

ARG BUCKET
WORKDIR /work

COPY requirements.txt ./
COPY query.sql ./
COPY usp.ipynb ./
COPY check.py ./
RUN pip install runipy
RUN pip install -r requirements.txt
RUN pip install awscli
RUN aws configure set region us-east-2
ENV BUCKET=${BUCKET}

EXPOSE 8888
CMD ["runipy", "usp.ipynb"]