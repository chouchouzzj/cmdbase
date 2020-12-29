# Copyright (c) 2014-present, The osquery authors
#
# This source code is licensed as defined by the LICENSE file found in the
# root directory of this source tree.
#
# SPDX-License-Identifier: (Apache-2.0 OR GPL-2.0-only)

set(CMAKE_EXPORT_COMPILE_COMMANDS true)

# Show verbose compilation messages when building Debug binaries
if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
  set(CMAKE_VERBOSE_MAKEFILE true)
endif()

set(third_party_source_list "source")

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/modules" CACHE STRING "A list of paths containing CMake module files")
set(OSQUERY_THIRD_PARTY_SOURCE "${third_party_source_list}" CACHE STRING "Sources used to acquire third-party dependencies")

