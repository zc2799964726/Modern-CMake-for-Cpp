cmake_minimum_required(VERSION 3.20.0)
project(Command CXX)

add_executable(main main.cpp constants.h)
target_include_directories(main PRIVATE ${CMAKE_BINARY_DIR})
add_custom_command(OUTPUT constants.h COMMAND cp ARGS "${CMAKE_SOURCE_DIR}/template.xyz" constants.h)

# 使用自定义目标有一个缺点——添加到ALL目标或开始为其他目标依赖于它们，每次都进行构建(可以在if块中启用它们以限制)
# 有时，这是你想要的，但定制行为是必要的，以产生不应该无故重新创建的文件:
# ·生成另一个目标所依赖的源代码文件
# ·将另一种语言翻译成C++
# ·紧接在构建另一个目标之前或之后执行自定义操作

# 自定义命令并不创建逻辑目标，但与自定义目标一样，其必须添加到依赖关系图中。有两种方法可以做到这一点——使用其输出工件作为可执行文件(或库)的源，或者显式地将其添加到自定义目标的DEPENDS列表中。

# 自定义命令有两个签名
# 上面是add_custom_target()的扩展版本 有输出文件的自定义命令

# add_custom_command()指令的第二个版本引入了在构建目标之前或之后执行命令的机制:
# add_custom_command(TARGET <target> PRE_BUILD | PRE_LINK | POST_BUILD 
                    # COMMAND command1 [ARGS] [args1...] 
                    # [COMMAND command2 [ARGS] [args2...] ...] 
                    # [BYPRODUCTS [files...]] 
                    # [WORKING_DIRECTORY dir] 
                    # [COMMENT comment] [VERBATIM] 
                    # [USES_TERMINAL] 
                    # [COMMAND_EXPAND_LISTS])
