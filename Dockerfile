ARG BASE_CONTAINER=jupyter/datascience-notebook
FROM $BASE_CONTAINER
MAINTAINER thisarasooriyarachchi@gmail.com

ARG BUCKET
ARG REGION
WORKDIR /work

COPY requirements.txt ./
COPY query.sql ./
COPY usp.ipynb ./
RUN pip install runipy
RUN pip install -r requirements.txt
RUN pip install awscli
RUN aws configure set region ${REGION}
ENV BUCKET=${BUCKET}

EXPOSE 8888
CMD ["runipy", "usp.ipynb"]
