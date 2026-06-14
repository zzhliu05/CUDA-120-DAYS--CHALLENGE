PROJECT = cuda_app.exe
NVCC = nvcc-build.cmd
SRCS = src/main.cu src/kernels.cu
HEADERS = include/kernels.h
INCLUDES = -I./include
ARCH = -arch=sm_75
FLAGS = -std=c++17 -lineinfo -Xcompiler "/W4 /O2 /MT"

.PHONY: all clean

all: $(PROJECT)

$(PROJECT): $(SRCS) $(HEADERS)
	$(NVCC) $(ARCH) $(FLAGS) $(INCLUDES) -o $(PROJECT) $(SRCS)

clean:
	cmd.exe /d /c if exist "$(PROJECT)" del /q "$(PROJECT)"
