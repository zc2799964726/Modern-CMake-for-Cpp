cmake_minimum_required(VERSION 3.20.0)
project(PropagatedProperties CXX)

add_library(source1 empty.cpp)
set_property(TARGET source1 PROPERTY INTERFACE_LIB_VERSION 4)
set_property(TARGET source1 APPEND PROPERTY
 COMPATIBLE_INTERFACE_STRING LIB_VERSION
)

add_library(source2 empty.cpp)
set_property(TARGET source2 PROPERTY INTERFACE_LIB_VERSION 4)

add_library(destination empty.cpp)
target_link_libraries(destination source1 source2)

# 将属性附加到其中一个，将触发传播和兼容性检查。
# BOOL列表将检查传播到目标目标的所有属性是否计算为相同的布尔值。
# 类似地，STRING将求值为字符串。
# UMBER_MAX和NUMBER_MIN有点不同——传播值不需要匹配，但目标只会接收最高或最低的值。