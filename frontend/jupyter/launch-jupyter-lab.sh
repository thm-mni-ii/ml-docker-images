#!/bin/bash
update-gdds.sh
exec jupyter lab --ip=0.0.0.0 --port=8888
