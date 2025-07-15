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
  RUN micromamba install -n base -c conda-forge -y htop curl wget zip unzip openssh jq inotify-tools git git-lfs screen tmux
  WORKDIR /workspace

common-cuda:
  FROM +common
  RUN micromamba install -n base -c conda-forge -y nvtop

build:
  ARG language
  ARG frontend
  BUILD +$language-$frontend

build-all-frontends:
  ARG language
  BUILD +build --language=$language --frontend=jupyter #--frontend=code

all:
  BUILD +build-all-frontends --language=python-cpu --language=python-cuda --language=rust --language=r

all-python:
  BUILD +build-all-frontends --language=python-cpu --language=python-cuda

all-r:
  BUILD +build-all-frontends --language=r

all-rust:
  BUILD +build-all-frontends --language=rust

all-python-cpu:
  BUILD +build-all-frontends --language=python-cpu

all-python-cuda:
  BUILD +build-all-frontends --language=python-cuda

full:
  FROM +common
  DO python+SETUP_CPU
  DO r+SETUP_CPU
  DO rust+SETUP_CPU

full-jupyter:
  FROM +full
  DO jupyter+SETUP
  DO r+JUPYTER_POST_INSTALL
  DO rust+JUPYTER_POST_INSTALL
  SAVE IMAGE --push $REGISTRY/full-jupyter:$VERSION

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
  FROM +common-cuda
  DO python+SETUP_CUDA

python-cuda-jupyter:
  FROM +python-cuda
  DO jupyter+SETUP
  SAVE IMAGE --push $REGISTRY/python-cuda-jupyter:$VERSION

python-cuda-code:
  FROM +python-cuda
  DO code+SETUP
  SAVE IMAGE --push $REGISTRY/python-cuda-code:$VERSION

r:
  FROM +common
  DO r+SETUP_CPU

r-jupyter:
  FROM +r
  DO jupyter+SETUP
  DO r+JUPYTER_POST_INSTALL
  SAVE IMAGE --push $REGISTRY/r-jupyter:$VERSION

rust:
  FROM +common
  DO rust+SETUP_CPU

rust-jupyter:
  FROM +rust
  DO jupyter+SETUP
  DO rust+JUPYTER_POST_INSTALL
  SAVE IMAGE --push $REGISTRY/rust-jupyter:$VERSION
