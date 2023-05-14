cmake_minimum_required(VERSION 3.20.0)
project(Configure CXX)

add_executable(configure configure.cpp)
set(FOO_ENABLE ON)
set(FOO_STRING1 "abc")
set(FOO_STRING2 "def")
configure_file(configure.h.in configured/configure.h)
target_include_directories(configure PRIVATE
                           ${CMAKE_CURRENT_BINARY_DIR})


# 若有多个变量，可以通过target_compile_definitions()传递定义可能会有一点开销
# 用configure_file(<input> <output>)指令，可以从这样的模板生成新的文件

# 把 input 文件中@VAR@或者 ${VAR} 引用的变量值 替换成 当前的变量值（注：CMake中的变量值）或者空串当变量未定义。input 默认是在 Source 文件夹里，也就是 ${CMAKE_CURRENT_SOURCE_DIR}/input，output 默认是在 Binary 文件夹里，也就是 ${CMAKE_CURRENT_BINARY_DIR}/output。

# 这里会在build目录中生成，所以使用了target_include_directories()指令将构建树目录添加到include路径中