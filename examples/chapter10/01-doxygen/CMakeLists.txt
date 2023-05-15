cmake_minimum_required(VERSION 3.20.0)
project(Doxygen CXX)
enable_testing()
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
add_subdirectory(src bin)

include(Doxygen)# 要使用这个函数，可以将其添加到项目的主列表文件中:include(Doxygen)
Doxygen(src docs)
