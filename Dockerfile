FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    git \
    build-essential \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN git clone https://github.com/pjreddie/darknet.git

WORKDIR /workspace/darknet

RUN sed -i 's/GPU=1/GPU=0/' Makefile && \
    sed -i 's/CUDNN=1/CUDNN=0/' Makefile && \
    sed -i 's/CUDNN_HALF=1/CUDNN_HALF=0/' Makefile && \
    sed -i 's/OPENCV=1/OPENCV=0/' Makefile && \
    make -j4

RUN wget https://pjreddie.com/media/files/yolov3.weights

WORKDIR /workspace

COPY detect.sh /workspace/detect.sh
RUN chmod +x /workspace/detect.sh

ENTRYPOINT ["./detect.sh"]
