# Copyright (c) 2014-present, The osquery authors
#
# This source code is licensed as defined by the LICENSE file found in the
# root directory of this source tree.
#
# SPDX-License-Identifier: (Apache-2.0 OR GPL-2.0-only)

# Set the build type
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_BUILD_TYPE "RelWithDebInfo" CACHE STRING "Build type (default RelWithDebInfo)" FORCE)
endif()

# Always generate the compile_commands.json file
set(CMAKE_EXPORT_COMPILE_COMMANDS true)

# Show verbose compilation messages when building Debug binaries
if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  set(CMAKE_VERBOSE_MAKEFILE true)
endif()


# We need to figure out the processor architecture and set the normalized variable
# before any targets are created
if(CMAKE_SYSTEM_PROCESSOR STREQUAL "AMD64")
  # Windows x86_64
  set(TARGET_PROCESSOR "x86_64")
elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
  # *nix x86_64
  set(TARGET_PROCESSOR "x86_64")
elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
  # *nix AArch64
  set(TARGET_PROCESSOR "aarch64")
else()
  message(FATAL_ERROR "Unsupported architecture ${CMAKE_SYSTEM_PROCESSOR}")
endif()

# TODO(alessandro): Add missing defines: PLATFORM_FREEBSD
if("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
  set(PLATFORM_POSIX 1)
  set(PLATFORM_LINUX 1)

elseif("${CMAKE_SYSTEM_NAME}" STREQUAL "Darwin")
  set(PLATFORM_POSIX 1)
  set(PLATFORM_MACOS 1)
elseif("${CMAKE_SYSTEM_NAME}" STREQUAL "Windows")
  set(PLATFORM_WINDOWS 1)
else()
  message(FATAL_ERROR "Unrecognized platform")
endif()
