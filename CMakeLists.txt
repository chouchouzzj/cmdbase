#
# Try to use subModule by git. 
# The thirdparty subModule is gflags
# and compiler is cmake.

cmake_minimum_required(VERSION 3.10)
project(cmakeLearn)

# 查找当前目录下的所有源文件
# 并将名称保存到 DIR_SRCS 变量
# 一定要有这句
aux_source_directory(. DIR_SRCS)

# 添加 math 子目录
add_subdirectory(math)

# 指定生成目标 
add_executable(cmakeLearn main.cpp)

# 添加链接库
target_link_libraries(cmakeLearn MathFunctions)
