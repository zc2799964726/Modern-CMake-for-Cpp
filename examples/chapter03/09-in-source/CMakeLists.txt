cmake_minimum_required(VERSION 3.20.0)
project(NoInSource CXX)

if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR "In-source builds are not allowed")
endif()
message("Build successful!")

# 禁用内构建 比较两个内置变量是否相等