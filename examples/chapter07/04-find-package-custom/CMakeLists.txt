cmake_minimum_required(VERSION 3.20.0)
project(FindPackageCustom CXX)

list(APPEND CMAKE_MODULE_PATH
            "${CMAKE_SOURCE_DIR}/cmake/module/")
find_package(PQXX REQUIRED)
message("FOUND: " ${PQXX_FOUND})
add_executable(main main.cpp)
target_link_libraries(main PRIVATE PQXX::PQXX)
# 编写自己的查找模块
# 可以为该库编写一个自定义查找模块，并将其与项目一起发布。这种情况并不理想，但为了照顾项目的用户，有时必须这样做。