cmake_minimum_required(VERSION 3.20.0)
project(FindPackageCustom CXX)

list(APPEND CMAKE_MODULE_PATH
            "${CMAKE_SOURCE_DIR}/cmake/module/")
# 首先编写一个新的FindPQXX.cmake文件，将它存储在项目源代码树的cmake/module目录中
# 需要确保当使用find_package()时，CMake可以找到这个查找模块，
# 所以会在CMakeLists.txt中将该目录追加到CMAKE_MODULE_PATH变量中
find_package(PQXX REQUIRED)
message("FOUND: " ${PQXX_FOUND})
add_executable(main main.cpp)
target_link_libraries(main PRIVATE PQXX::PQXX)
# 编写自己的查找模块
# 可以为该库编写一个自定义查找模块，并将其与项目一起发布。这种情况并不理想，但为了照顾项目的用户，有时必须这样做。