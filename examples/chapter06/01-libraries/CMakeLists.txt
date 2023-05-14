cmake_minimum_required(VERSION 3.20.0)
project(Libraries CXX)

add_library(my_static STATIC function_a.cpp function_b.cpp)
add_library(my_shared SHARED function_a.cpp function_b.cpp)
add_library(my_module MODULE function_a.cpp function_b.cpp)

# MODULE关键字 动态库的一种，目的是作为运行时加载的插件使用，而不是在编译过程中链接到可执行文件

# 共享模块不会在程序启动时自动加载(像普通的共享库一样)。只有程序通过LoadLibrary(Windows)或dlopen()/dlsym() (Linux/macOS)等系统调用显式地请求它时，才会使用的到
# 不应该尝试将可执行文件与模块链接起来，因为这并不能保证在所有平台上都能工作