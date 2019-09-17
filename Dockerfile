ARG BASE_CONTAINER=jupyter/datascience-notebook
FROM $BASE_CONTAINER
MAINTAINER thisarasooriyarachchi@gmail.com

WORKDIR /work

COPY requirements.txt ./
COPY query.sql ./
COPY usp.ipynb ./
COPY check.py ./
RUN pip install -r requirements.txt
RUN pip install awscli 


EXPOSE 8888
#CMD ["runipy", "test_jupyter.ipynb"]
