# after building this file - read files generated in the build tree

cmake_minimum_required(VERSION 3.20.0)
project(Genex CXX)

set(myvar "small text")
set(myvar2 "small text >")

file(GENERATE OUTPUT nesting CONTENT
  "1 $<PLATFORM_ID>
  2 $<UPPER_CASE:$<PLATFORM_ID>>
  3 $<UPPER_CASE:hello world>
  4 $<UPPER_CASE:${myvar}>
  5 $<UPPER_CASE:${myvar2}>
")

file(GENERATE OUTPUT boolean CONTENT
  "1 $<0:TRUE>
  2 $<0:TRUE,FALSE> (won't work)
  3 $<1:TRUE,FALSE>
  4 $<IF:0,TRUE,FALSE>
  5 $<IF:0,TRUE,>
")
add_custom_target(gendbg COMMAND ${CMAKE_COMMAND} -E echo 
"1 $<PLATFORM_ID>")
# 生成器表达式
# 语法:
# $<EXPRESSION:arg1,arg2,arg3>
# 表达式通常是在使用的目标上下文中求值的
# 甚至有些表达式不需要任何参数，例如$<PLATFORM_ID>

# 1如何调试
# 生成器表达式将在生成阶段计算(当配置完成并创建构建系统时)，
# 所以不能将其输出捕获到变量中，并打印到控制台。

# 要调试可以使用以下方法:
# •将其写入一个文件(file()指令的这个特定版本支持生成器表达式):
# file(GENERATE OUTPUT filename CONTENT "$<...>")
# •添加一个自定义目标，并根据命令行显式构建: 
# 命令行:cmake --build 05-genex/build/ --target gendbg
# 命令行:cmake --build 05-genex/build/ -t gendbg
# CMakeLists:add_custom_target(gendbg COMMAND ${CMAKE_COMMAND} -E echo "$<...>")

# 2 各种用例
# 条件表达式(由于历史原因，它的语法不一致，很难阅读)
# 第一种形式支持成功和失败的路径:
# <IF:condition,true_string,false_string> 这里的语法与所有其他表达式对齐，并且与所有表达一样，允许嵌套

# 第二种形式是前一种的缩写;只有满足以下条件，才会展开为字符串:
# $<condition:true_string >
# 3 计算类型
# 生成器表达式可以计算成两种类型——布尔或字符串。布尔值由1(真)和0(假)表示。其他的都只是一个字符串。

# 4 查询依赖的目标 **
# 通过以下查询，可以计算可执行文件或库目标的属性
# $<TARGET_LINKER_FILE:target> 目标二进制文件的目录
# $<TARGET_PDB_FILE:target>链接器为目标生成的程序数据库文件(.pdb)的完整路径。
# $<TARGET_PROPERTY:target,prop>目标的prop值。
# $<TARGET_PROPERTY:prop>要对表达式求值目标的prop值
# $<INSTALL_PREFIX>当目标用install(EXPORT)导出，或者当在INSTALL_NAME_DIR中求值时的安装目录，若不存在为空。

# 查询变量 $<TARGET_EXISTS:arg> $<PLATFORM_ID:args> $<COMPILE_LANG_AND_ID:lang,compiler_id1,compiler_id2...>