VERSION 0.8

IMPORT ./common AS common
IMPORT ./language/python AS python
IMPORT ./language/r AS r
IMPORT ./language/rust AS rust
IMPORT ./frontend/jupyter AS jupyter
IMPORT ./frontend/code AS code

ARG --required --global REGISTRY
ARG --required --global VERSION

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
  FROM common+common
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
  FROM common+common
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
  FROM common+common-cuda
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
  FROM common+common
  DO r+SETUP_CPU

r-jupyter:
  FROM +r
  DO jupyter+SETUP
  DO r+JUPYTER_POST_INSTALL
  SAVE IMAGE --push $REGISTRY/r-jupyter:$VERSION

rust:
  FROM common+common
  DO rust+SETUP_CPU

rust-jupyter:
  FROM +rust
  DO jupyter+SETUP
  DO rust+JUPYTER_POST_INSTALL
  SAVE IMAGE --push $REGISTRY/rust-jupyter:$VERSION
