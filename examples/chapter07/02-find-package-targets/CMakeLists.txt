cmake_minimum_required(VERSION 3.20.0)
project(FindPackageProtobufTargets CXX)

find_package(Protobuf REQUIRED)
protobuf_generate_cpp(GENERATED_SRC GENERATED_HEADER
                      message.proto)

add_executable(main main.cpp
                    ${GENERATED_SRC} ${GENERATED_HEADER})
target_link_libraries(main PRIVATE protobuf::libprotobuf)
target_include_directories(main PRIVATE
                                ${CMAKE_CURRENT_BINARY_DIR})
# 导入的目标 protobuf::libprotobuf隐式指定包含目录，并且由于传递依赖项(我称之为传播属性)，它们与我们的主目标共享。同样的过程也发生在链接器和编译器标志上。
