cmake_minimum_required(VERSION 3.23)
project(CompStruct C ASM)

set(CMAKE_C_STANDARD 90)

set(GCC_COVERAGE_COMPILE_FLAGS "-no-pie")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS}")
add_executable(CompStruct main.c hello.s)
