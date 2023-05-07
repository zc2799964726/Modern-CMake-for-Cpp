cmake_minimum_required(VERSION 3.20.0)
project(Rental CXX)
include(cars/cars.cmake)
add_executable(Rental
               main.cpp
               ${cars_sources}
               # ${more variables}
)

# 此方法的缺点
# 1来自嵌套目录的变量会污染顶层作用域(反之亦然)
# 2所有的目录将共享相同的配置: