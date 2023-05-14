cmake_minimum_required(VERSION 3.20.0)
project(FindPkgConfig CXX)

find_package(PkgConfig REQUIRED)
pkg_check_modules(PQXX REQUIRED IMPORTED_TARGET libpqxx)
# 用模块中定义的pkg_check_modules()帮助命令扫描包。
# 调用FindPkgConfig查找模块中定义的pkg_check_modules()自定义宏，以PQXX作为所选名称创建一个新的导入目标。查找模块将搜索名为libpxx的依赖项，若库因为REQUIRED关键字而不可用，将再次失败。注意IMPORTED_TARGET关键字——若没有它，就不会自动创建目标，必须用宏手动定义它。
message("PQXX_FOUND: ${PQXX_FOUND}")
message("PQXX_INCLUDE_DIRS: ${PQXX_INCLUDE_DIRS}")
message("PQXX_INCLUDES: ${PQXX_INCLUDES}")
message("PQXX_LIBRARIES: ${PQXX_LIBRARIES}")
message("PQXX_LIBS: ${PQXX_LIBS}")
message("PQXX_DEFINITIONS: ${PQXX_DEFINITIONS}")

add_executable(main main.cpp)
target_link_libraries(main PRIVATE PkgConfig::PQXX)

# 首先需要安装apt-get install libpqxx-dev

# CMake提供了一个方便的内置查找模块——FindPkgConfig。它遵循了常规查找模块的大多数规则，但没有提供PKG_CONFIG_INCLUDE_DIRS或PKG_CONFIG_LIBS变量，而是设置了一个直接指向二进制文件的变量——PKG_CONFIG_EXECUTABLE

# 管理依赖关系和发现所需的所有编译标志的问题和C++库本身一样古老，有许多工具可以处理它。其中一个(曾经非常流行)工具叫做PkgConfig
# •若一个库非常流行，可能已经在CMake中有它的查找模块。这种情况下，就不需要它。
# •若没有查找模块(或者它对库不起作用)，并且该库只提供PkgConfig.pc，那么使用现成的即可。

# 开始使用find_package()，若_FOUND为false，退回到PkgConfig。通过这种方式，可以使用一种环境升级的方式，可以只使用主方法，而不更改代码。
# 这个助手工具的概念非常简单——库的作者提供了一个包含编译和链接所需细节的小的.pc文件:
# prefix=/usr/local 
# exec_prefix=${prefix} 
# includedir=${prefix}/include 
# libdir=${exec_prefix}/lib

# Name: foobar 
# Description: A foobar library 
# Version: 1.0.0 
# Cflags: -I${includedir}/foobar 
# Libs: -L${libdir} -lfoobar
# 虽然PkgConfig非常容易使用，但功能非常有限:
# •检查系统中是否存在库，以及是否提供了.pc文件•检查是否有足够的库版本可用
# •通过运行pkg-config --libs libfoo获取库的链接器标志
# •获取库的包含目录(该字段在技术上可以包含其他编译器标志) ——pkg-config --cflags libfoo