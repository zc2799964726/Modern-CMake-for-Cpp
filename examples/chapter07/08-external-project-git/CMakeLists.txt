cmake_minimum_required(VERSION 3.20.0)
project(ExternalProjectGit CXX)

add_executable(welcome main.cpp)
configure_file(config.yaml config.yaml COPYONLY)

include(ExternalProject)
ExternalProject_Add(external-yaml-cpp
  GIT_REPOSITORY    https://github.com/jbeder/yaml-cpp.git
  GIT_TAG           yaml-cpp-0.6.3
)
target_link_libraries(welcome PRIVATE yaml-cpp)


include(CMakePrintHelpers)
cmake_print_properties(TARGETS yaml-cpp
                       PROPERTIES TYPE SOURCE_DIR)
# ExternalProject_Add()可以接受超过85种不同的选择:
# •管理外部项目的目录结构
# •从URL下载源代码(若需要，还可以从压缩包中提取)
# •支持Git、Subversion、Mercurial和CVS库•若需要，可以获取更新
# •使用CMake、Make或用户指定的工具配置和构建项目
# •执行安装和运行测试
# •日志文件
# •终端请求用户输入
# •依赖于其他目标
# •向构建中添加自定义命令/步骤
# ExternalProject模块在构建阶段填充依赖项。对于ExternalProject_Add()添加的每个外部项目， CMake将执行以下步骤:

# 1. mkdir–为外部项目创建子目录
# 2. download–从存储库或URL获取项目文件
# 3. update–重新运行时支持增量更新的下载方式
# 4. patch–可选地执行一个补丁命令，根据项目的需要更改下载的文件
# 5. configure–执行CMake项目的配置阶段，或者手动指定非CMake依赖项的命令
# 6. build–执行CMake项目的构建阶段，而对于其他依赖项，执行make命令
# 7. install–安装CMake项目，对于其他依赖，执行make install命令
# 8. test–若选择性的定义了TEST_…，则执行依赖项的测试

# 使用Git下载依赖项
# GIT_REPOSITORY <url> 
# GIT_TAG <tag>

# 使用Subversion下载依赖项
# SVN_REPOSITORY <url> 
# SVN_REVISION -r<rev>

# 使用Mercurial下载依赖项
# HG_REPOSITORY <url> 
# HG_TAG <tag>