#!/bin/bash

cd /home/model
git clone $MODEL_URL .
git-lfs fetch
python3 /home/convert.py
