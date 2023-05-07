cmake_minimum_required(VERSION 3.20.0)
project(Features CXX)

list(FIND CMAKE_CXX_COMPILE_FEATURES
          cxx_variable_templates result)
if(result EQUAL -1)
  message(FATAL_ERROR "I really need variable templates.")
endif()

add_executable(Features main.cpp)

# 使用的每个功能编写一个文档是一项艰巨的任务。甚至CMake的作者也建议只检查是否存在某些高级元特性:cxx_std_98、cxx_std_11、cxx_std_14、cxx_std_17、cxx_std_20和cxx_std_23，每个元特性都表明编译器支持特定的C++标准。
#https://cmake.org/cmake/help/latest/prop_gbl/CMAKE_CXX_KNOWN_FEATURES.html