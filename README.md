# RkllmDockerConvertor

Easy way to convert models into rkllm format.

### How to use:

1) Clone repository:
```
git clone https://github.com/ProKn1fe/RkllmDockerConvertor
```
2) Build container image:
```
cd RkllmDockerConvertor
docker build -t rkllmconvertor .
```
3) Run container with model repository:
```
docker run -i --volume D:\Test\:/home/model -e MODEL_URL=https://huggingface.co/Qwen/Qwen3-0.6B rkllmconverter
```

Note that you need mount `/home/model` to any folder outside container which will contain cloned model repository and converter model.

Awailable parameters for container:
```
MODEL_URL - repository url
DTYPE - float32, float16, bfloat16
PLATFORM - rk3588
OPTIMIZATION_LEVEL - 1
QUANTIZED_DTYPE - w8a8/w8a8_gx/w4a16/w4a16_gx
QUANTIZED_ALGORITHM - normal, grq
NPU_CORES_COUNT - 3
```
