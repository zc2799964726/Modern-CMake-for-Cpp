# CMake可以提供更多变量，但为了节省时间，不会查询环境中很少需要的信息
# 需要提供一个目标变量和感兴趣的键的列表。若只提供一个键，则变量将只包含一个值;否则，它将是一个值列表。

# 1关于环境和操作系统的细节:
cmake_host_system_information(RESULT l1 QUERY 
HOSTNAME 
TOTAL_VIRTUAL_MEMORY
AVAILABLE_VIRTUAL_MEMORY
TOTAL_PHYSICAL_MEMORY
OS_RELEASE
#OS_VERSION
)
message(STATUS "${l1}")

# 2特定于处理器的信息:
cmake_host_system_information(RESULT l2 QUERY 
NUMBER_OF_LOGICAL_CORES # 逻辑核数
IS_64BIT # 若处理器是64位，则为1
HAS_SSE # 若果处理器支持SSE指令，则返回1
HAS_IA64 # 若是模拟x86的IA-64处理器，则返回1
)
message(STATUS "${l2}")

# 3平台是32位还是64位架构?
message(STATUS "${CMAKE_SIZEOF_VOID_P}")
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  message(STATUS "Target is 64 bits")
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
  message(STATUS "Target is 32 bits")
endif()

# 4系统的端序 chapter01/04可以利用模块去验证
# 大多数情况下，字节顺序并不重要，但当编写需要可移植的位代码时，CMake将为你提供一个BIG_ENDIAN或LITTLE_ENDIAN值存储在CMAKE_<lang>_BYTE_ORDER变量中，其中<lang>为C、CXX、OBJC或CUDA。
cmake_policy(SET CMP0010 OLD)
message(STATUS "${CMAKE_CXX_BYTE_ORDER}")