VERSION 0.8

IMPORT ./language/python AS python
IMPORT ./language/r AS r
IMPORT ./language/rust AS rust
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
  BUILD +all-r
  BUILD +all-rust

all-python:
  BUILD +all-python-cpu
  BUILD +all-python-cuda

all-r:
  BUILD +all-r-cpu

all-rust:
  BUILD +all-rust-cpu

all-python-cpu:
  BUILD +python-cpu-jupyter
  BUILD +python-cpu-code

all-python-cuda:
  BUILD +python-cuda-jupyter
  BUILD +python-cuda-code

all-r-cpu:
  BUILD +r-cpu-jupyter

all-rust-cpu:
  BUILD +rust-cpu-jupyter

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

r-cpu:
  FROM +common
  DO r+SETUP_CPU

r-cpu-jupyter:
  FROM +r-cpu
  DO jupyter+SETUP
  DO r+JUPYTER_POST_INSTALL
  SAVE IMAGE --push $REGISTRY/r-jupyter:$VERSION

rust-cpu:
  FROM +common
  DO rust+SETUP_CPU

rust-cpu-jupyter:
  FROM +rust-cpu
  DO jupyter+SETUP
  DO rust+JUPYTER_POST_INSTALL
  SAVE IMAGE --push $REGISTRY/rust-jupyter:$VERSION
