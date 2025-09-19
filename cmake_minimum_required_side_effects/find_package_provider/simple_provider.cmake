# Either leave cmake_minimum_required at the top
# or comment it out and use cmake_policy inside the block
cmake_minimum_required(VERSION 3.25)

macro(simple_provider method name)
    block(SCOPE_FOR POLICIES)
        #cmake_policy(VERSION 3.25)
        message("Provider called for ${name}")
        message("CMAKE_MINIMUM_REQUIRED_VERSION during find_package call: ${CMAKE_MINIMUM_REQUIRED_VERSION}")
        cmake_policy(GET CMP0140 cmp140SettingDuring)
        message("CMake policy CMP0140 during find_package call: ${cmp140SettingDuring}")
        unset(cmp140SettingDuring)
        if(${name} STREQUAL "MyPkg")
            add_subdirectory(MyPkg)
            set(${name}_FOUND TRUE)
        endif()
    endblock()
endmacro()

cmake_language(SET_DEPENDENCY_PROVIDER simple_provider
        SUPPORTED_METHODS FIND_PACKAGE)
