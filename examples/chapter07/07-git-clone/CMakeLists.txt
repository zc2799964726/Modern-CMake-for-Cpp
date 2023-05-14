cmake_minimum_required(VERSION 3.20.0)
project(GitClone CXX)

add_executable(welcome main.cpp)
configure_file(config.yaml config.yaml COPYONLY)

find_package(yaml-cpp QUIET)
if (NOT yaml-cpp_FOUND)
  message("yaml-cpp not found, cloning git repository")
  find_package(Git)
  if (NOT Git_FOUND)
    message(FATAL_ERROR "Git not found, can't initialize!")
  endif ()
  execute_process(
    COMMAND ${GIT_EXECUTABLE} clone
    https://github.com/jbeder/yaml-cpp.git
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/extern
  )
  add_subdirectory(extern/yaml-cpp)
endif()
target_link_libraries(welcome PRIVATE yaml-cpp)

# Git对于有一定经验的开发人员特别有吸引力，非常适合不包含对相同存储库的嵌套引用的较小项目。
# 但若是这样，将发现可能需要多次克隆和构建同一个项目。若依赖项项目根本不使用Git，则需要另一种解决方案。
# 使用ExternalProject和FetchContent模块