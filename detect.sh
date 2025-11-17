#!/bin/bash

URL=$1

if [ -z "$URL" ]; then
  echo "Usage: docker run --rm <image_name> <image_url>"
  exit 1
fi

cd /workspace/darknet

wget -O input.jpg "$URL"

./darknet detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights input.jpg -dont_show
