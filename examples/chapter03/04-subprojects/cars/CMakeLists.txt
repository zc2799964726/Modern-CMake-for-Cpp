cmake_minimum_required(VERSION 3.20.0)
project(CarProject CXX)

add_library(cars OBJECT
    car.cpp
#   car_maintenance.cpp
)
target_include_directories(cars PUBLIC .)

# 可能需要一个选项来将事情慢慢地分解为更独立的部分——将它们放在单独的构建
# 流水中，或者只是在更小的范围上工作

# 可以通过向嵌套目录中的列表文件添加project()来实现