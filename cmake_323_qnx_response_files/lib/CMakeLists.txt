

if(NAMES_WITH_HYPHEN)
    set(targetNamePrefix "my_library_files_with_hyphen-and-very_long_names_to_trigger_generation_of_response_files")
else()
    set(targetNamePrefix "my_library_files_without_hyphen_and_very_long_names_to_trigger_generation_of_response_files")
endif()


# Generate an huge amount of object files which are linked to the same executable
# If the name contains a hyphen CMake escapes it 
foreach(number RANGE ${NUMBER_OF_OBJECT_FILES})
    set(targetName ${targetNamePrefix}_${number})
    set(functionName doStuff_${number})
    set(generatedHeaderFile "${CMAKE_CURRENT_BINARY_DIR}/${targetName}.h")
    set(generatedSourceFile "${CMAKE_CURRENT_BINARY_DIR}/${targetName}.c")

    configure_file("${CMAKE_CURRENT_SOURCE_DIR}/lib.h.in"
        "${generatedHeaderFile}" @ONLY)
    configure_file("${CMAKE_CURRENT_SOURCE_DIR}/lib.c.in"
        "${generatedSourceFile}" @ONLY)

    list(APPEND sourcesList "${generatedSourceFile}")
endforeach()

# Interface library to force all object files appear on one linker command line
add_library(my_library INTERFACE)
target_sources(my_library INTERFACE ${sourcesList})
