#!/bin/bash
update-gdds.sh
exec micromamba -n base run $@
