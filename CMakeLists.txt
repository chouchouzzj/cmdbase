#
# Try to use subModule by git. 
# The thirdparty subModule is gflags
# and compiler is cmake.

cmake_minimum_required(VERSION 3.10)

include(cmake/utilities.cmake)

project(cmdbase)

include(cmake/globals.cmake)
include(cmake/flags.cmake)
include(cmake/options.cmake)


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

function(importLibraries)
    set(library_descriptor_list
            "Linux,Darwin,Windows:gflags"
            )

    foreach(library_descriptor ${library_descriptor_list})
		message(WARNING "\n\n--=--=--=--=--=--=-- library_descriptor\n"
		"library_descriptor: ${library_descriptor}\n"
		"CMAKE_MODULE_PATH: ${CMAKE_MODULE_PATH}\n"
		"--=--=--=--=--=--=--\n\n")

        # Expand the library descriptor
        string(REPLACE ":" ";" library_descriptor "${library_descriptor}")

        list(GET library_descriptor 0 platform_list)
        list(GET library_descriptor 1 library)

        string(REPLACE "," ";" platform_list "${platform_list}")

        list(FIND platform_list "${CMAKE_SYSTEM_NAME}" platform_index)
        if(platform_index EQUAL -1)
            continue()
        endif()

        find_package("${library}" REQUIRED)

        # Skip libraries which already use our internal target name
        if(TARGET "thirdparty_${library}")
            message(WARNING "\n\n--=--=--=--=--=--=--1
            thirdparty_${library}   已有的构建目标或导入目标
            --=--=--=--=--=--=--\n\n")
            continue()

            # For generic libraries that import the library name, let's create
            # an alias
        endif()
    endforeach()
endfunction()


function(enableOsqueryWEL)
  message(WARNING "\n\n--=--=--=--=--=--=-- enableOsqueryWEL
  Global variable TOOLS_WEL_FILES_ROOT_DIR: ${TOOLS_WEL_FILES_ROOT_DIR}
  --=--=--=--=--=--=--\n\n")
  # Global variable TOOLS_WEL_FILES_ROOT_DIR: D:/Project/cmake/tools
  target_sources(osqueryd PRIVATE "${TOOLS_WEL_FILES_ROOT_DIR}/windows_resources.rc")
endfunction()


add_subdirectory("libraries")
importLibraries()

# generateOsqueryd 生成 exe 并 链接库
# 并将名称保存到 DIR_SRCS 变量
aux_source_directory(. DIR_SRCS)
foreach(File_Source ${DIR_SRCS})
  message(STATUS "-------------Source File are: ${File_Source}")
endforeach()
# 指定生成目标
add_executable(cmdbase ${DIR_SRCS})
target_link_libraries (cmdbase ${EXTRA_LIBS} thirdparty_gflags)

message(WARNING "\n\n--=--=--=--=--=--=--
Global variable CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}
Global variable PROJECT_SOURCE_DIR: ${PROJECT_SOURCE_DIR}
Global variable PROJECT_BINARY_DIR: ${PROJECT_BINARY_DIR}
Global variable PROJECT_SOURCE_DIR: ${PROJECT_SOURCE_DIR}
--=--=--=--=--=--=--\n\n")









