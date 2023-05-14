cmake_minimum_required(VERSION 3.20.0)
project(Precompile CXX)

add_executable(precompiled hello.cpp)
target_precompile_headers(precompiled PRIVATE <iostream>)

# 本例中 cmake_pch.hxx 在<build-tree>/CMakeFiles/precompiled.dir下

# 为了减少编译时间 可以使用一些技术——头文件预编译和统一构建
# PCH技术

# 头文件(.h)在实际编译开始之前由预处理器包含在翻译单元中，所以每次.cpp实现文件更改时都必须重新编译。若多个翻译文件使用相同的共享头文件，那么每次包含它时都必须编译它。这是一种浪费，但在很长一段时间里情况就是这样。
# 从3.16版本开始，CMake提供了一个命令来启用头预编译这允许编译器将头文件与实现文件分开处理，从而加快编译速度
# 添加的头文件列表存储在PRECOMPILE_HEADERS目标属性中。第4章已经介绍，可以使用PUBLIC或INTERFACE关键字，通过传播的属性与依赖的目标共享，但对于通过install()指令导出的目标不行。其他项目不应该强制使用预编译的头文件。

# 若需要内部预编译头文件，并且仍然想安装-导出目标文件，$<BUILD_INTERFACE:...>的生成器表达式将防止头文件出现在使用中，但仍然会添加到使用export()指令从构建树导出的目标中。

# CMake将把所有头文件的名称放在一个cmake_pch.hxx文件中，然后该文件将预编译为一个特定于编译器的二进制文件，扩展名为.pch、.gch或.pchi

# main.cpp文件中，不需要包含cmake_pch.h或任何其他头文件——将由cmake使用特定于编译器的命令行选项强制包含。

# CMake不需要担心太多，特别是在正确地组织了项目的情况下(具有相对较小的目标，专注于单个领域)。每个目标都有一个单独的预编译头文件，其限制了头文件更改的影响。
# 另一方面，若头文件相当稳定，那么在另一个目标中重用预编译的头文件是个好主意。CMake为此提供了一个方便的指令:
# target_precompile_headers(<target> REUSE_FROM <other_target>)
# 这将设置重用头文件的目标的PRECOMPILE_HEADERS_REUSE_FROM属性，并在这些目标之间创建一个依赖关系

# 请注意需求，特别是使用双括号格式([[”header.h”]])使用头文件。两个目标都需要设置头文件包含路径，以确保编译器能够找到这些头文件。