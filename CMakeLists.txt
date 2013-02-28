CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
project (MuPython)

if (${CMAKE_CURRENT_BINARY_DIR} STREQUAL ${PROJECT_SOURCE_DIR})
    message (FATAL_ERROR "ERROR: Please choose a different build directory. ${PROJECT_NAME} build directory (for all downloads & builds) can be specified via -D PROJECT_BINARY_DIR=<path> on cmake command line.")
    #set (MU_BUILD_DIR ${PROJECT_SOURCE_DIR})
endif ()

set (MU_REPO_DIR ${PROJECT_SOURCE_DIR})
set (MU_BUILD_DIR ${CMAKE_CURRENT_BINARY_DIR})
set (MU_INSTALL_DIR ${CMAKE_INSTALL_PREFIX})

message ("${PROJECT_NAME} downloads and builds will be placed here: ${MU_BUILD_DIR}")

############################################################################

# Set CMAKE_MODULE_PATH
SET(CMAKE_MODULE_PATH  ${CMAKE_MODULE_PATH}  ${MU_REPO_DIR})
SET(CMAKE_MODULE_PATH  ${CMAKE_MODULE_PATH}  ${MU_REPO_DIR}/pkgs)
SET(CMAKE_MODULE_PATH  ${CMAKE_MODULE_PATH}  ${MU_REPO_DIR}/support)

message("Using cmake modules from ${CMAKE_MODULE_PATH}")

message ("BUILD: ${PROJECT_BINARY_DIR}")

message ("CMAKE source dir: ${CMAKE_SOURCE_DIR}")

#include(ProcessorCount)
#ProcessorCount(PROCESSOR_COUNT)
#if(NOT PROCESSOR_COUNT EQUAL 0)
#    message ("Number of processors: ${PROCESSOR_COUNT}")
#    set(CTEST_BUILD_FLAGS -j${PROCESSOR_COUNT})
#    set(ctest_test_args ${ctest_test_args} PARALLEL_LEVEL ${N})
#endif()

include (python)

add_custom_target (AppDependencies ALL
        DEPENDS ${APP_DEPENDENCIES}
        COMMENT "Installed all required software using ${PROJECT_NAME}.")

