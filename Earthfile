VERSION 0.8

IMPORT ./language/python AS python
IMPORT ./language/julia AS julia
IMPORT ./frontend/jupyter AS jupyter
IMPORT ./frontend/code AS code

ARG --required --global REGISTRY
ARG --required --global VERSION

common:
  FROM mambaorg/micromamba:1.5.8
  RUN micromamba install -n base -c conda-forge  -y htop nvtop
  WORKDIR /workspace

all:
  BUILD +all-python

all-python:
  BUILD +python-jupyter
  BUILD +python-code

python:
  FROM +common
  DO python+SETUP

python-jupyter:
  FROM +python
  DO jupyter+SETUP
  SAVE IMAGE --push $REGISTRY/python-jupyter:$VERSION

python-code:
  FROM +python
  DO code+SETUP
  SAVE IMAGE --push $REGISTRY/python-code:$VERSION
