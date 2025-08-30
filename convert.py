from rkllm.api import RKLLM
import os
os.environ['CUDA_VISIBLE_DEVICES']='0'

# Get settings from env
modelpath = '/home/model'
dtype = os.getenv('DTYPE')
target_platform = os.getenv('PLATFORM')
optimization_level = os.getenv('OPTIMIZATION_LEVEL')
quantized_dtype = os.getenv('QUANTIZED_DTYPE')
quantized_algorithm = os.getenv('QUANTIZED_ALGORITHM')
num_npu_core = os.getenv('NPU_CORES_COUNT')

llm = RKLLM()
ret = llm.load_huggingface(model=modelpath, model_lora = None, device='cuda', dtype=dtype, custom_config=None, load_weight=True)

if ret != 0:
    print('Load model failed!')
    exit(ret)

ret = llm.build(do_quantization=True, optimization_level=optimization_level, quantized_dtype=quantized_dtype,
                quantized_algorithm=quantized_algorithm, target_platform=target_platform, num_npu_core=num_npu_core, extra_qparams=None, dataset=None, hybrid_rate=0, max_context=4096)

if ret != 0:
    print('Build model failed!')
    exit(ret)

# Export rkllm model
ret = llm.export_rkllm(f"./{os.path.basename(modelpath)}_{quantized_dtype}_{target_platform}.rkllm")
if ret != 0:
    print('Export model failed!')
    exit(ret)
