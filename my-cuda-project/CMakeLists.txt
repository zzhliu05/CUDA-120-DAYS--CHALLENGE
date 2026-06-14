cmake_minimum_required(VERSION 3.24)

project(my_cuda_project LANGUAGES CXX CUDA)

add_executable(my_cuda_project
    src/main.cu
    src/kernels.cu
)

target_include_directories(my_cuda_project PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}/include"
)

set_target_properties(my_cuda_project PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED YES
    CUDA_STANDARD 17
    CUDA_STANDARD_REQUIRED YES
    CUDA_ARCHITECTURES 75
    MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>"
)
