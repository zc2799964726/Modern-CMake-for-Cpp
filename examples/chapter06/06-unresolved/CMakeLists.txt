cmake_minimum_required(VERSION 3.20.0)
project(Order CXX)

add_library(outer outer.cpp)
add_library(nested nested.cpp)

add_executable(main main.cpp)
target_link_libraries(main nested outer)

# 连接顺序和未定义符号

# 解析未定义符号的工作方式是这样的——链接器从左向右处理二进制文件。当链接器遍历二进制文件时，将执行以下操作:
# 1.收集从此二进制文件导出的所有未定义符号，并存储起来以备以后使用
# 2.尝试用此二进制文件中定义的符号解析未定义的符号(从处理的二进制文件中收集)
# 3.对下一个二进制文件重复此过程
# 若在整个操作完成后，若有符号仍未定义，则链接失败。我们的例子中就是这样(CMake把可执行目标的目标文件放在库之前):

# 1.主要处理main.o，获得对a的未定义引用，并收集它以用于将来的解析。
# 2.处理libnested.a，没有发现未定义的引用，因此没有什么需要解析的。
# 3.处理libouter.a，得到了对b的未定义引用，并解析了对A的引用。

# 我们确实正确地解析了对a变量的引用，但对b没有。需要做的是颠倒链接的顺序，使nested排在outer之后:
# target_link_libraries(main outer nested)
# 另一个不那么优雅的选项是重复库 (这对循环引用很有用):
# target_link_libraries(main nested outer nested)