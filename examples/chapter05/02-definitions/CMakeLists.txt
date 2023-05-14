cmake_minimum_required(VERSION 3.20.0)
project(Definitions CXX)

# without definitions:
add_executable(undefined definitions.cpp)

# with definitions
set(VAR 8)
add_executable(defined definitions.cpp)
target_compile_definitions(defined PRIVATE ABC "DEF=${VAR}")
# 可以用CMake传递宏定义到C++的预处理器
# target_compile_definitions指令
# 这些定义通常以-D标志——-DFOO=1——传递给编译器
# target_compile_definitions(hello PRIVATE -DFOO)

# CMake可以识别这一点，并将删除任何前导-D标志。也会忽略空字符串，所以可以这样写:
# target_compile_definitions(hello PRIVATE -D FOO)