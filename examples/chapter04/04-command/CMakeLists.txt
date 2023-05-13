cmake_minimum_required(VERSION 3.20.0)
project(Command CXX)

add_executable(main main.cpp)
add_custom_command(TARGET main POST_BUILD
                   COMMAND cksum ARGS "$<TARGET_FILE:main>" > "main.ck")


# 第一个参数中发生了什么?它不是一个变量，因为不是包装在花括号(${})中，而是在尖括号($<>)中，
# 而这是一个生成器表达式，计算到目标二进制文件的完整路径。这种机制在许多目标属性的上下文中非常有用。
# 详细见05 生成器表达式