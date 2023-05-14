cmake_minimum_required(VERSION 3.20.0)
project(Defaults CXX)

add_executable(print_commit print_commit.cpp)
execute_process(COMMAND git log -1 --pretty=format:%h
                OUTPUT_VARIABLE SHA)

# above will work only if git is configured in this directory
# we'll set a dummy value if that's not the case
if(SHA STREQUAL "")
  set(SHA d670460b4b4aece5915caf5c68d12f560a9fe3e4)
endif()

target_compile_definitions(print_commit PRIVATE "SHA=${SHA}")

# execute_process命令
# 这条命令可以执行一个或多个命令作为当前命令的子命令，将输出的结果保存到cmake变量或文件中，所有的进程使用单个的标准错误输出管道。
