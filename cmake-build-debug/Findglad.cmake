

include(FindPackageHandleStandardArgs)

message(STATUS "Conan: Using autogenerated Findglad.cmake")
# Global approach
set(glad_FOUND 1)
set(glad_VERSION "0.1.29")

find_package_handle_standard_args(glad REQUIRED_VARS glad_VERSION VERSION_VAR glad_VERSION)
mark_as_advanced(glad_FOUND glad_VERSION)



set(glad_INCLUDE_DIRS "/Users/pete/.conan/data/glad/0.1.29/bincrafters/stable/package/94d23a5b6799ba50e68988fd8c0740e6c4ee9b52/include")
set(glad_INCLUDES "/Users/pete/.conan/data/glad/0.1.29/bincrafters/stable/package/94d23a5b6799ba50e68988fd8c0740e6c4ee9b52/include")
set(glad_DEFINITIONS )
set(glad_LINKER_FLAGS_LIST "" "")
set(glad_COMPILE_DEFINITIONS )
set(glad_COMPILE_OPTIONS_LIST "" "")
set(glad_LIBRARIES_TARGETS "") # Will be filled later, if CMake 3
set(glad_LIBRARIES "") # Will be filled later
set(glad_LIBS "") # Same as glad_LIBRARIES

mark_as_advanced(glad_INCLUDE_DIRS
                 glad_INCLUDES
                 glad_DEFINITIONS
                 glad_LINKER_FLAGS_LIST
                 glad_COMPILE_DEFINITIONS
                 glad_COMPILE_OPTIONS_LIST
                 glad_LIBRARIES
                 glad_LIBS
                 glad_LIBRARIES_TARGETS)

# Find the real .lib/.a and add them to glad_LIBS and glad_LIBRARY_LIST
set(glad_LIBRARY_LIST glad)
set(glad_LIB_DIRS "/Users/pete/.conan/data/glad/0.1.29/bincrafters/stable/package/94d23a5b6799ba50e68988fd8c0740e6c4ee9b52/lib")
foreach(_LIBRARY_NAME ${glad_LIBRARY_LIST})
    unset(CONAN_FOUND_LIBRARY CACHE)
    find_library(CONAN_FOUND_LIBRARY NAME ${_LIBRARY_NAME} PATHS ${glad_LIB_DIRS}
                 NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
    if(CONAN_FOUND_LIBRARY)
        list(APPEND glad_LIBRARIES ${CONAN_FOUND_LIBRARY})
        if(NOT ${CMAKE_VERSION} VERSION_LESS "3.0")
            # Create a micro-target for each lib/a found
            set(_LIB_NAME CONAN_LIB::glad_${_LIBRARY_NAME})
            if(NOT TARGET ${_LIB_NAME})
                # Create a micro-target for each lib/a found
                add_library(${_LIB_NAME} UNKNOWN IMPORTED)
                set_target_properties(${_LIB_NAME} PROPERTIES IMPORTED_LOCATION ${CONAN_FOUND_LIBRARY})
            else()
                message(STATUS "Skipping already existing target: ${_LIB_NAME}")
            endif()
            list(APPEND glad_LIBRARIES_TARGETS ${_LIB_NAME})
        endif()
        message(STATUS "Found: ${CONAN_FOUND_LIBRARY}")
    else()
        message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
        list(APPEND glad_LIBRARIES_TARGETS ${_LIBRARY_NAME})
        list(APPEND glad_LIBRARIES ${_LIBRARY_NAME})
    endif()
endforeach()
set(glad_LIBS ${glad_LIBRARIES})

if(NOT ${CMAKE_VERSION} VERSION_LESS "3.0")
    # Target approach
    if(NOT TARGET glad::glad)
        add_library(glad::glad INTERFACE IMPORTED)
        
    if(glad_INCLUDE_DIRS)
      set_target_properties(glad::glad PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${glad_INCLUDE_DIRS}")
    endif()
    set_property(TARGET glad::glad PROPERTY INTERFACE_LINK_LIBRARIES ${glad_LIBRARIES_TARGETS} "${glad_LINKER_FLAGS_LIST}")
    set_property(TARGET glad::glad PROPERTY INTERFACE_COMPILE_DEFINITIONS ${glad_COMPILE_DEFINITIONS})
    set_property(TARGET glad::glad PROPERTY INTERFACE_COMPILE_OPTIONS "${glad_COMPILE_OPTIONS_LIST}")

        
    endif()
endif()
