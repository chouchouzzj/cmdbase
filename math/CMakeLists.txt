#
# Try to use subModule by git. 
# The thirdparty subModule is gflags
# and compiler is cmake.

# 查找当前目录下的所有源文件
# 并将名称保存到 DIR_LIB_SRCS 变量
aux_source_directory(. DIR_LIB_SRCS)
# 生成链接库
add_library (MathFunctions ${DIR_LIB_SRCS})
target_include_directories(MathFunctions PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
message(WARNING "\n\n--=--=--=--=--=--=-- \n"
		"target_include_directories(MathFunctions PUBLIC {CMAKE_CURRENT_SOURCE_DIR})\n"
		"CMAKE_CURRENT_SOURCE_DIR : ${CMAKE_CURRENT_SOURCE_DIR}"
		"--=--=--=--=--=--=--\n\n")
