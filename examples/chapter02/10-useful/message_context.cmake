cmake_minimum_required(VERSION 3.20.0)

function(foo)
  #list(APPEND CMAKE_MESSAGE_CONTEXT "foo")
  list(APPEND CMAKE_MESSAGE_INDENT " ")
  message("foo message")
endfunction()

#list(APPEND CMAKE_MESSAGE_CONTEXT "top")

message("Before `foo`")
foo()
message("After `foo`")
# 这里需要使用cmake -P chapter02/10-useful/message_context.cmake --log-context 
# 当启用命令行标志cmake --log-context时，消息将装饰为点分隔的上下文，并存储在CMAKE_MESSAGE_CONTEXT列表中。
# message()的另一个很酷的技巧是在CMAKE_MESSAGE_INDENT列表中添加缩进(与CMAKE_MESSAGE_CONTEXT的方法完全相同):
# list(APPEND CMAKE_MESSAGE_INDENT " ")
