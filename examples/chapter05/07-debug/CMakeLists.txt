cmake_minimum_required(VERSION 3.20.0)
project(Debug CXX)

add_executable(debug hello.cpp)
target_compile_options(debug PRIVATE -save-temps=obj)
# 各个阶段的调试有一个-save-temps标志可以传递给编译器(GCC和Clang都有)，将强制每个阶段的输出存储在一个文件而不是内存中
add_executable(inclusion hello.cpp)
target_compile_options(inclusion PRIVATE -H)
# 头文件的调试问题
# 若发现自己处于一个需要精确理解哪些路径用来包含请求的头文件的位置，可以使用-H
# build时可以看到结果

# CMake 3.16还引入了另一个编译时间优化特性——统一构建或巨型构建。统一构建用#include
# 指令组合多个实现源文件(毕竟，编译器不知道包含的是头文件还是实现)。其中，有些是真的有用
# 的，而另一些是潜在的有害的。

# 重新编译时，大型构建是不可取的，因为会编译比所需的多得多的文件。当代码要以尽可能快
# 的速度编译所有文件时，其工作效率最高。

# 要启用统一构建，有两个选项:
# •将CMAKE_UNITY_BUILD变量设置为true——在此之后，定义的每个目标上都会初始化UNITY_BUILD属性。
# •在每个应该使用统一构建的目标上手动设置UNITY_BUILD为true。
# 第二个选项是通过以下函数实现的:
# set_target_properties(<target1> <target2> ... 
# PROPERTIES UNITY_BUILD true)

# 不支持C++20的模块(cmake 3.21版本開始正式支持 编译器支持CMake也要适配的)
# C++20中引入新特性——模块。这是一个重大的游戏规则改变者，其允许使用头文件时避免许多麻烦，减少构建时间，并允许更干净、更紧凑的代码，
# 更容易浏览和推理

# 注意，这里不再依赖于预处理器;模块有自己的关键字——import、export和module

# 想要完整体验c++modules，也可以尝试Xmake，目前gcc/clang/msvc基本都支持了│

