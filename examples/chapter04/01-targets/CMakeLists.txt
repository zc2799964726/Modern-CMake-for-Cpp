cmake_minimum_required(VERSION 3.20.0)
project(BankApp CXX)

add_executable(terminal_app terminal_app.cpp)
add_executable(gui_app gui_app.cpp)

target_link_libraries(terminal_app calculations)
target_link_libraries(gui_app calculations drawing)

add_library(calculations calculations.cpp)
add_library(drawing drawing.cpp)

add_custom_target(checksum ALL
                  COMMAND sh -c "cksum terminal_app>terminal.ck"
                  COMMAND sh -c "cksum gui_app>gui.ck"
                  BYPRODUCTS terminal.ck gui.ck 
                  COMMENT "Checking the sums..."
)

add_dependencies(checksum terminal_app gui_app)

# 本文的add_custom_target会根据命令的参数生成一个target，这个target相对的可以更定制化一点。
# 一 构建目标（通俗版）
# 1 构建目标中的add_custom_target
# add_custom_target 如果不加ALL 的话，最后构建是不会放在all target 里面进行构建的 对于这种target，需要make <target-name>才会执行
# all target的意思是，在cmake之后，make会生成和执行all target内所有的target。
# 例如add_executable和add_library默认就会生成在all target中。但如果在add_exe命令中加入EXCLUDE_FROM_ALL，才会从all target中移除，即make不会默认生成

# 构建目标（专业版）Modern CMake 这么介绍和使用的：
# “CMake在默认情况下生成它来包含所有顶层列表文件目标，比如可执行文件和库(不一定是自定义目标)。ALL是在运行cmake --build <build tree>而不选择具体目标时生成的，
# 可以通过向前面的命令添加--target <name>参数来选择一个。”

# 1.1 target之间可以有依赖关系
# add_dependencies(A B C) 可以告知Cmake A 依赖BC
# cmake --graphviz=test.dot ./build/可生成dot可视化的脚本
# 1.2
# BYPRODUCTS需要和COMMAND配合使用，如果漏了COMMAND则会报错

# 二 非目标机制add_custom_command
# 非目标机制可以创建可在所有实际目标中使用的自定义工件——自定义命令add_custom_command。