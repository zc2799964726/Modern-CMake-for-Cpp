cmake_minimum_required(VERSION 3.20.0)
project(Optimize CXX)
add_executable(inline inline.cpp)
add_executable(unroll unroll.cpp)

# 许多编译器默认情况下不会启用任何优化(包括GCC)
# O1到O3，优化级别逐渐升高，且级别高的包含前面级别低的所有优化。
# 只要开了优化，无论-O1, -O2, -O3代码执行顺序都会被打乱，对于调试不太好。

# -O1优化:这个级别开始就会对指令进行重排了（编译器级别的，不是CPU级别）、会简单的删除一些多余的条件分支、减少不必要的栈帧开辟
# -O2优化:这个级别并不会做循环展开
# 它的额外优化比如：
# 1）强制将内存上的数据拷贝到寄存器上再执行该数据相关的指令，所以如果多个指令都要用到该数据，那就节省了再次将数据从内存拷贝到寄存器的时间
# 2）还可以多个函数调用合并为一个函数调用（这个在编译选项-funit-at-a-time中做到

# -O3优化：
# 这个级别才有循环展开、函数内联

# 可以使用target_compile_options()指令，并确切地指定想从编译器获得的内容

# target_compile_options(<target> [BEFORE] 
# <INTERFACE|PUBLIC|PRIVATE> [items1...] 
# [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
# 该命令还可以用来为类似编译器的-D定义提供其他参数，为此CMake还提供了target_compile_definition()指令

# 例子上分别是：内联/循环展开Loop Unrolling 
# 从有问题的函数中提取代码，并将其放在调用函数的所有位置，替换原始调用并节省宝贵的CPU周期。
# -finline-functions-called-once:只有GCC可用
# • -finline-functions: Clang和GCC都可用
# • -finline-hint-functions:只有Clang可用
# • -finline-functions-called-once:只有GCC可用

# 循环展开是一种优化技术，方法是将循环转换为一组语句，以达到相同的效果
# 每个编译器提供的该标志版本略有不同:
# • -floop-unroll: GCC
# • -funroll-loops: Clang

# 测试发现-funroll-loops 是gcc的

target_compile_options(inline PUBLIC -finline-functions)
target_compile_options(unroll PUBLIC -funroll-loops)
