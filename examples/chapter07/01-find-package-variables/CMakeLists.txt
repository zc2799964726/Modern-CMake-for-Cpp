cmake_minimum_required(VERSION 3.20.0)
project(FindPackageProtobufVariables CXX)

find_package(Protobuf REQUIRED)
protobuf_generate_cpp(GENERATED_SRC GENERATED_HEADER
                      message.proto)

add_executable(main main.cpp
                    ${GENERATED_SRC} ${GENERATED_HEADER})
target_link_libraries(main PRIVATE ${Protobuf_LIBRARIES})
target_include_directories(main PRIVATE
                                ${Protobuf_INCLUDE_DIRS}
                                ${CMAKE_CURRENT_BINARY_DIR})

# 若不是很熟悉Protobuf，只需要知道这个库提供了一种以二进制形式序列化结构化数据的机制。
# 为此，需要提供这种结构的模式，用于从二进制形式向C++对象进行读写。

# Protobuf有一个特殊的编译器，可以读取这些文件并生成C++源文件和头文件，然后应用就可以使用这些文件了。
# 所以需要以某种方式将这个编译步骤添加到流程中：
# target_include_directories()添加包提供的必要的INCLUDE_DIRS和CMAKE_CURRENT_BINARY_DIR。
# 这里需要后者，这样编译器才能找到生成的message.pb.h头文件。

# protobuf_generate_cpp是在protobuf查找模块中定义的自定义函数。
# 在底层调用add_custom_command()，后者使用适当的参数调用协议编译器。
# 可以通过提供两个变量来使用这个函数，将生成的源文件(GENERATED_SRC)和头文件(GENERATED_HEADER)的路径，以及要编译的文件列表(message.proto)。

# find_package(Protobuf REQUIRED)要求CMake运行绑定的FindProtobuf.cmake建立了Protobuf库。该查找模块将扫描常用路径，若没有找到库，则终止(因为提供了REQUIRED关键字)。
# 其还将指定有用的变量和函数(例如下一行中的函数)

# 当使用find_package()时，可以预期会设置一些变量，无论使用的是内置的查找模块，还是与包绑定的包配置文件(假设找到了包):
# • <PKG_NAME>_FOUND
# • <PKG_NAME>_INCLUDE_DIRS或<PKG_NAME>_INCLUDES
# • <PKG_NAME>_LIBRARIES或<PKG_NAME>_LIBRARIES或<PKG_NAME>_LIBS
# • <PKG_NAME>_DEFINITIONS
# • IMPORTED由查找模块或配置文件指定的目标
# 最后一点非常有趣——若包支持所谓的“现代CMake”(围绕目标构建)，其将提供那些导入的目标来代替(或伴随)这些变量，这允许更干净、更简单的代码。
