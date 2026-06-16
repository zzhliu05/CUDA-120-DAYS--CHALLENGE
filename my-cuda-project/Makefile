PROJECT = cuda_app.exe
NVCC = nvcc-build.cmd
INCLUDES = -I./include
ARCH = -arch=sm_75
FLAGS = -std=c++17 -lineinfo -Xcompiler "/W4 /O2 /MT"

.PHONY: all clean

all: cpu gpu

cpu: src/main_cpu.c
	$(NVCC) $(ARCH) $(FLAGS) $(INCLUDES) -o cpu src/main_cpu.c

gpu: src/main_gpu.cu
	$(NVCC) $(ARCH) $(FLAGS) $(INCLUDES) -o gpu src/main_gpu.cu

clean:
	cmd.exe /d /c if exist "cpu" del /q "cpu"
	cmd.exe /d /c if exist "gpu" del /q "gpu"
