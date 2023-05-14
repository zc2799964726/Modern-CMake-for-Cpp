cmake_minimum_required(VERSION 3.20.0)
project(ExternalProjectGit CXX)

add_executable(welcome main.cpp)
configure_file(config.yaml config.yaml COPYONLY)

include(FetchContent)
FetchContent_Declare(external-yaml-cpp
  GIT_REPOSITORY    https://github.com/jbeder/yaml-cpp.git
  GIT_TAG           yaml-cpp-0.6.3
)
FetchContent_MakeAvailable(external-yaml-cpp)
target_link_libraries(welcome PRIVATE yaml-cpp)

include(CMakePrintHelpers)
cmake_print_properties(TARGETS yaml-cpp
                       PROPERTIES TYPE SOURCE_DIR)
# 建议使用FetchContent模块来导入外部项目
# 本质上，它是ExternalProject的高级包装器，提供类似的功能和更多功能

# 与ExternalProject(构建阶段填充依赖项)不同，
# FetchContent在配置阶段填充依赖项，将外部项目声明的所有目标带入主项目的范围。

# 回顾以下 cmake的三个阶段config generate build

# FetchContent模块的使用需要三个步骤:
# 1.用include(FetchModule)将该模块包含到项目中。
# 2.使用FetchContent_Declare()指令配置依赖项。
# 3.使用FetchContent_MakeAvailable()指令填充依赖项——下载、构建、安装，并将其列表文件添加到主项目并进行解析

# 为什么Declare和MakeAvailable命令是分开的。这样做是为了在分层项目中启用配置重写

# FetchContent_MakeAvailable()的细节:
# 1.调用FetchContent_GetProperties()将FetchContent_Declare()设置的配置从全局变量读取到本地变量。
# 2.检查(不区分大小写)带有此名称的依赖项是否已经填充，以避免下载两次。
# 3.使用FetchContent_Populate()，将通过转发设置的选项(但跳过禁用的选项)和下载依赖项来配置包装的ExternalProject模块。还会设置一些变量，以防止在后续调用中重新下载，并将必要的路径转发到下一个指令。
# 4.最后，使用源码树和构建树作为参数调用add_subdirectory()，以告诉父项目列表文件在哪里，以及将构建构件放在哪里。

# 提一下,build阶段时,先build依赖项,最后构建自己的项目,很慢