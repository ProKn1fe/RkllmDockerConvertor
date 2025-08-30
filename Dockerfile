FROM ubuntu:noble

# Link to rkllm python package
ARG RKLLM_URL=https://github.com/airockchip/rknn-llm/raw/refs/heads/main/rkllm-toolkit/rkllm_toolkit-1.2.1-cp312-cp312-linux_x86_64.whl
# Link to model repository
ARG MODEL_URL=https://huggingface.co/Qwen/Qwen3-0.6B
# Model conversion parameters
ARG DTYPE=float32
ARG PLATFORM=rk3588
ARG OPTIMIZATION_LEVEL=1
ARG QUANTIZED_DTYPE=w8a8
ARG QUANTIZED_ALGORITHM=normal
ARG NPU_CORES_COUNT=3

# Move all arg to env variables
ENV RKLLM_URL=${RKLLM_URL}
ENV MODEL_URL=${MODEL_URL}
ENV DTYPE=${DTYPE}
ENV PLATFORM=${PLATFORM}
ENV OPTIMIZATION_LEVEL=${OPTIMIZATION_LEVEL}
ENV QUANTIZED_DTYPE=${QUANTIZED_DTYPE}
ENV QUANTIZED_ALGORITHM=${QUANTIZED_ALGORITHM}
ENV NPU_CORES_COUNT=${NPU_CORES_COUNT}

COPY req.txt /home/req.txt
COPY convert.py /home/convert.py
COPY convert.sh /home/convert.sh

# Install required packages
RUN apt update && \
	apt install -y python3 python3-pip git git-lfs curl wget

# Install rkllm pip package
RUN cd /home && \
	export BUILD_CUDA_EXT=0 && \
	wget $RKLLM_URL && \
	pip3 install rkllm_*.whl --break-system-packages && \
	pip3 install -r req.txt --break-system-packages && \
	chmod +x /home/convert.sh

ENTRYPOINT ["/bin/bash"]
CMD ["/home/convert.sh"]
