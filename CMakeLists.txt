#
# Try to use subModule by git. 
# The thirdparty subModule is gflags
# and compiler is cmake.

cmake_minimum_required(VERSION 3.10)
project(cmakeLearn)
# 加入一个配置头文件，用于处理 CMake 对源码的设置
# 通过这样的机制，将可以通过预定义一些参数和变量来控制代码的生成
configure_file (
	"${PROJECT_SOURCE_DIR}/config/config.h.in"
	"${PROJECT_BINARY_DIR}/config/config.h"
)
# 是否使用自己的 MathFunctions 库
# option 命令添加了一个 USE_MYMATH 选项，并且默认值为 ON
option (USE_MYMATH "Use provided math implementation" ON)

# 是否加入 MathFunctions 库
if (USE_MYMATH)
 include_directories ("${PROJECT_SOURCE_DIR}/math")
 add_subdirectory (math)
 set (EXTRA_LIBS ${EXTRA_LIBS} MathFunctions)
endif (USE_MYMATH)

include_directories ("${PROJECT_BINARY_DIR}/config")
add_subdirectory (config)

# 并将名称保存到 DIR_SRCS 变量
aux_source_directory(. DIR_SRCS)
foreach(File_Source ${DIR_SRCS})
  message(STATUS "-------------Source File are: ${File_Source}")
endforeach()
# 指定生成目标
add_executable(Demo ${DIR_SRCS})
target_link_libraries (Demo ${EXTRA_LIBS})

message(STATUS "-------------Show Global variable CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
message(STATUS "-------------Show Global variable PROJECT_SOURCE_DIR: ${PROJECT_SOURCE_DIR}")
message(STATUS "-------------Show Global variable PROJECT_BINARY_DIR: ${PROJECT_BINARY_DIR}")
message(STATUS "-------------Show Global variable PROJECT_SOURCE_DIR: ${EXTRA_LIBS}")

