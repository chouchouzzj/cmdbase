# Copyright (c) 2014-present, The osquery authors
#
# This source code is licensed as defined by the LICENSE file found in the
# root directory of this source tree.
#
# SPDX-License-Identifier: (Apache-2.0 OR GPL-2.0-only)

# This function modifies an existing cache variable but without changing its description
function(overwrite_cache_variable variable_name type value)
  get_property(current_help_string CACHE "${variable_name}" PROPERTY HELPSTRING)
  if(NOT DEFINED current_help_string)
    set(current_help_string "No description")
  endif()
  list(APPEND cache_args "CACHE" "${type}" "${current_help_string}")
  set("${variable_name}" "${value}" ${cache_args} FORCE)
endfunction()

function(collectInterfaceOptionsFromTarget)
  set(oneValueArgs TARGET COMPILE DEFINES LINK)
  cmake_parse_arguments(PARSE_ARGV 0 osquery "" "${oneValueArgs}" "")

  message(WARNING "\n\n--=--=--=--=--=--=-- collectInterfaceOptionsFromTarget
  osquery_TARGET : ${osquery_TARGET}
  --=--=--=--=--=--=--\n\n")

  if(NOT osquery_TARGET OR NOT TARGET ${osquery_TARGET})
    message(FATAL_ERROR "A valid target has to be provided")
  endif()

  set(target_list ${osquery_TARGET})
  set(target_list_length 1)

  while(${target_list_length} GREATER 0)
    foreach(target ${target_list})

      if(NOT TARGET ${target})
        continue()
      endif()

      get_target_property(target_type ${target} TYPE)

      if(NOT "${target_type}" STREQUAL "INTERFACE_LIBRARY")
        continue()
      endif()

      get_target_property(dependencies ${target} INTERFACE_LINK_LIBRARIES)

      if(NOT "${dependencies}" STREQUAL "dependencies-NOTFOUND")
        list(APPEND new_target_list ${dependencies})
      endif()

      get_target_property(compile_options ${target} INTERFACE_COMPILE_OPTIONS)
      get_target_property(compile_definitions ${target} INTERFACE_COMPILE_DEFINITIONS)
      get_target_property(link_options ${target} INTERFACE_LINK_OPTIONS)

      if(osquery_COMPILE AND NOT "${compile_options}" STREQUAL "compile_options-NOTFOUND")
        list(APPEND compile_options_list ${compile_options})
      endif()

      if(osquery_DEFINES AND NOT "${compile_definitions}" STREQUAL "compile_definitions-NOTFOUND")
        list(APPEND compile_definitions_list ${compile_definitions})
      endif()

      if(osquery_LINK AND NOT "${link_options}" STREQUAL "link_options-NOTFOUND")
        list(APPEND link_options_list ${link_options})
      endif()
    endforeach()

    set(target_list ${new_target_list})
    list(LENGTH target_list target_list_length)
    unset(new_target_list)
  endwhile()

  list(REMOVE_DUPLICATES compile_options_list)
  list(REMOVE_DUPLICATES compile_definitions_list)
  list(REMOVE_DUPLICATES link_options_list)

  if(osquery_COMPILE)
    set(${osquery_COMPILE} ${compile_options_list} PARENT_SCOPE)
  endif()

  if(osquery_LINK_OPTIONS)
    set(${osquery_LINK_OPTIONS} ${link_options_list} PARENT_SCOPE)
  endif()

  if(osquery_DEFINES)
    set(${osquery_DEFINES} ${compile_definitions_list} PARENT_SCOPE)
  endif()

endfunction()

function(copyInterfaceTargetFlagsTo destination_target source_target mode)

  message(WARNING "\n\n--=--=--=--=--=--=-- collectInterfaceOptionsFromTarget\n"
  "TARGET : ${source_target}\n"
  "COMPILE : ${compile_options_list}\n"
  "LINK : ${link_options_list}\n"
  "DEFINES : ${compile_definitions_list}\n"
  "--=--=--=--=--=--=--\n\n")

  collectInterfaceOptionsFromTarget(TARGET ${source_target}
          COMPILE compile_options_list
          LINK link_options_list
          DEFINES compile_definitions_list
          )

  get_target_property(dest_compile_options_list ${destination_target} INTERFACE_COMPILE_OPTIONS)
  get_target_property(dest_compile_definitions_list ${destination_target} INTERFACE_COMPILE_DEFINITIONS)
  get_target_property(dest_link_options_list ${destination_target} INTERFACE_LINK_OPTIONS)

  if("${dest_compile_options_list}" STREQUAL "dest_compile_options_list-NOTFOUND")
    unset(dest_compile_options_list)
  endif()

  if("${dest_compile_definitions_list}" STREQUAL "dest_compile_definitions_list-NOTFOUND")
    unset(dest_compile_definitions_list)
  endif()

  if("${dest_link_options_list}" STREQUAL "dest_link_options_list-NOTFOUND")
    unset(dest_link_options_list)
  endif()

  list(APPEND dest_compile_options_list ${compile_options_list})
  list(APPEND dest_compile_definitions_list ${compile_definitions_list})
  list(APPEND dest_link_options_list ${link_options_list})

  target_compile_options(${destination_target} ${mode} ${dest_compile_options_list})
  target_compile_definitions(${destination_target} ${mode} ${dest_compile_definitions_list})
  target_link_options(${destination_target} ${mode} ${dest_link_options_list})
endfunction()