function(Doxygen input output)
  find_package(Doxygen)
  if (NOT DOXYGEN_FOUND)
    add_custom_target(doxygen COMMAND false
                              COMMENT "Doxygen not found")
    return()
  endif()
  # 若不可用，将创建一个伪doxygen目标，通知用户并运行一个错误命令，该命令(在类Unix系统上)返回1，导致构建失败。这时用return()结束函数
  set(DOXYGEN_GENERATE_HTML YES)
  set(DOXYGEN_HTML_OUTPUT   ${PROJECT_BINARY_DIR}/${output})
# 若Doxygen可用，将在提供的输出目录中生成HTML。Doxygen是可配置的(在官方文档中找到更多信息)，要设置任何选项，只需按照示例调用set()并在其名称前加上DOXYGEN_。
  doxygen_add_docs(doxygen
      ${PROJECT_SOURCE_DIR}/${input}
      COMMENT "Generate HTML documentation"
  )
endfunction()
# 遵循前几章的实践，创建一个带有辅助函数的程序模块(可以在其他项目中重用)
# 函数接受两个参数——输入和输出目录——并将创建一个自定义doxygen目标

# doxygen_add_docs(targetName [sourceFilesOrDirs...] 
# [ALL] [USE_STAMP_FILE] [WORKING_DIRECTORY dir] 
# [COMMENT comment])
# 第一个参数指定目标名称，需要用-t参数显式地构建cmake(在生成构建树之后):
# cmake --build <build-tree> -t targetName
# 或者，可以通过添加ALL参数来构建(通常没有必要)
# 允许CMake在没有任何源文件更改的情况下跳过文档的重新生成(但要求sourceFilesOrDirs只包含文件)。