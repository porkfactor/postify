# Copyright (c) 2020 Arduino CMake Toolchain

# No need to include this recursively
if(_TOOLCHAIN_COMMON_UTILS_INCLUDED)
    return()
endif()
set(_TOOLCHAIN_COMMON_UTILS_INCLUDED TRUE)

# Make a string ready for quoting
function(string_escape_quoting _string_var)
    string(REPLACE "\\" "\\\\" _escaped_str "${${_string_var}}")
    string(REPLACE "\"" "\\\"" _escaped_str "${_escaped_str}")
    set("${_string_var}" "${_escaped_str}" PARENT_SCOPE)
endfunction()

# Check if two files are the same
function(check_same_file file1 file2 _ret_var)
    get_filename_component(x "${file1}" ABSOLUTE)
    get_filename_component(y "${file2}" ABSOLUTE)
    if (x STREQUAL y)
        set("${_ret_var}" TRUE PARENT_SCOPE)
    else()
        set("${_ret_var}" FALSE PARENT_SCOPE)
    endif()
endfunction()

# Add file(s) as configure dependency so that CMake re-runs when
# those files change
function(add_configure_dependency file)
    foreach(item IN LISTS ARGN ITEMS "${file}")
        # message("Configure dependency: ${item}")
        set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS "${item}")
    endforeach()
endfunction()

