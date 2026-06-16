PROJECT = cuda_app.exe
NVCC = nvcc-build.cmd
INCLUDES = -I./include
ARCH = -arch=sm_75
FLAGS = -std=c++17 -lineinfo -Xcompiler "/W4 /O2 /MT"

.PHONY: all clean

all: day3 day4


day3: cpu gpu

cpu: src/main_cpu.c
	$(NVCC) $(ARCH) $(FLAGS) $(INCLUDES) -o cpu src/main_cpu.c

gpu: src/main_gpu.cu
	$(NVCC) $(ARCH) $(FLAGS) $(INCLUDES) -o gpu src/main_gpu.cu


day4: vectoradd matmul

vectoradd: src/vectorp.cu
	$(NVCC) $(ARCH) $(FLAGS) $(INCLUDES) -o vectoradd src/vectorp.cu
matmul: src/matmul.cu
	$(NVCC) $(ARCH) $(FLAGS) $(INCLUDES) -o matmul src/matmul.cu

clean:
	rm -f cpu gpu matmul vectoradd
