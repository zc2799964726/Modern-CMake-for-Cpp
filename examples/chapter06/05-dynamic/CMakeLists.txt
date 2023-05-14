cmake_minimum_required(VERSION 3.20.0)
project(Dynamic CXX)

add_library(a SHARED a.cpp)
add_library(b SHARED b.cpp)

add_executable(main_1 main.cpp)
target_link_libraries(main_1 a b)

add_executable(main_2 main.cpp)
target_link_libraries(main_2 b a)
# 链接器确实关心链接库的顺序。若不小心的话，这可能会造成一些混乱。实际上，
# 命名冲突并不像看上去那么罕见。
# 为了简单起见，将使用extern在本地声明它们
# 使用命名空间——不要依赖链接器
