VERSION 0.8

IMPORT ./language/python AS python
IMPORT ./language/julia AS julia
IMPORT ./frontend/jupyter AS jupyter
IMPORT ./frontend/code AS code

ARG --required --global REGISTRY
ARG --required --global VERSION

common:
  FROM mambaorg/micromamba:1.5.8
  ENV SHELL=/bin/bash
  RUN micromamba install -n base -c conda-forge -y htop nvtop
  WORKDIR /workspace

all:
  BUILD +all-python

all-python:
  BUILD all-python-cpu
  BUILD all-python-cuda

all-python-cpu:
  BUILD +python-cpu-jupyter
  BUILD +python-cpu-code

all-python-cuda:
  BUILD +python-cuda-jupyter
  BUILD +python-cuda-code

python-cpu:
  FROM +common
  DO python+SETUP_CPU

python-cpu-jupyter:
  FROM +python-cpu
  DO jupyter+SETUP
  SAVE IMAGE --push $REGISTRY/python-jupyter:$VERSION

python-cpu-code:
  FROM +python-cpu
  DO code+SETUP
  SAVE IMAGE --push $REGISTRY/python-code:$VERSION

python-cuda:
  FROM +common
  DO python+SETUP_CUDA

python-cuda-jupyter:
  FROM +python-cuda
  DO jupyter+SETUP
  SAVE IMAGE --push $REGISTRY/python-cuda-jupyter:$VERSION

python-cuda-code:
  FROM +python-cuda
  DO code+SETUP
  SAVE IMAGE --push $REGISTRY/python-cuda-code:$VERSION
