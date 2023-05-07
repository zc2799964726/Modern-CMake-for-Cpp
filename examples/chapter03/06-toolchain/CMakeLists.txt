cmake_minimum_required(VERSION 3.20.0)
project(Standard CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include(CheckIPOSupported)
check_ipo_supported(RESULT ipo_supported)
if(ipo_supported)
  set(CMAKE_INTERPROCEDURAL_OPTIMIZATION True)
endif()

add_executable(Standard main.cpp)

# 对于CMake项目，工具链包含构建和运行应用程序时使用的所有工具——
# 例如，工作环境、生成器、CMake可执行程序本身和编译器
# toolchain: ENV Generator Cmake compiler

# 1设定C++标准 set_property(TARGET <target> PROPERTY CXX_STANDARD <standard>)
# 2坚持支持标准 set(CMAKE_CXX_STANDARD_REQUIRED ON)
# 3特定于供应商的扩展 set(CMAKE_CXX_EXTENSIONS OFF)
#    为了实现这一点，CMake会将-std=gnu++14，而不是-std=c++14添加到编译行
#    若切换到另一个编译器(或者您的用户切换到另一个编译器!)，代码可能无法构建
# 4过程间优化
# 需要设置的默认变量叫做CMAKE_INTERPROCEDURAL_OPTIMIZATION。在设置它之前，需要确保支持，以避免错误:
#include(CheckIPOSupported)
#check_ipo_supported(RESULT ipo_supported)
#if(ipo_supported)
#  set(CMAKE_INTERPROCEDURAL_OPTIMIZATION True)
#endif()

# 5检查支持的编译器特性 07-feature
# CMake会在配置阶段询问编译器，并在CMAKE_CXX_COMPILE_FEATURES变量中存储可用特性的列表

# 6编译测试文件 08-test_run