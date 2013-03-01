# Initialize PythonMu build variables
# 
# Sets the following variables:
#
#   MU_BIN_DIR         Binary directory (/bin)
#   MU_LIB_DIR         Library directory (/lib)
#   MU_SRC_DIR         Source directory (/src)
#   MU_INCLUDE_DIR     Include directory (/include)
#
#   MU_BIN_PATH        Command path string suitable for PATH env variable.
#   MU_LIB_PATH        Library path string suitable for LD_LIBRARY_PATH env variable.
#   MU_ENV_STRING      Environment variable setting string for use before commands.

if (NOT MU_ENV_STRING)

#if (NOT MU_BUILD_DIR)
#    message (FATAL_ERROR "ERROR: ${PROJECT_NAME} build directory (for all downloads & builds) should be specified via -DMU_BUILD_DIR=<path> on cmake command line.")
#endif ()

# Make sure the main directories for PythonMu build directory are already 
# created so paths won't error out.
set (MU_BIN_DIR    ${MU_BUILD_DIR}/bin)
if (NOT EXISTS ${MU_BIN_DIR})
    file (MAKE_DIRECTORY ${MU_BIN_DIR})
endif ()

set (MU_TEST_DIR    ${MU_BUILD_DIR}/bin/tests)
if (NOT EXISTS ${MU_TEST_DIR})
    file (MAKE_DIRECTORY ${MU_TEST_DIR})
endif ()

set (MU_LIB_DIR    ${MU_BUILD_DIR}/lib)
if (NOT EXISTS ${MU_LIB_DIR})
    file (MAKE_DIRECTORY ${MU_LIB_DIR})
endif ()

set (MU_INCLUDE_DIR    ${MU_BUILD_DIR}/include)
if (NOT EXISTS ${MU_INCLUDE_DIR})
    file (MAKE_DIRECTORY ${MU_INCLUDE_DIR})
endif ()

set (MU_SRC_DIR    ${MU_BUILD_DIR}/src)
if (NOT EXISTS ${MU_SRC_DIR})
    file (MAKE_DIRECTORY ${MU_SRC_DIR})
endif ()

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    # Important to use FALLBACK variable.
    # https://developer.apple.com/library/mac/#documentation/DeveloperTools/Conceptual/DynamicLibraries/100-Articles/DynamicLibraryUsageGuidelines.html
    set (MU_LD_LIBRARY_VAR "DYLD_FALLBACK_LIBRARY_PATH")
    set (MU_PLATFORM_SPECIFIC_ENV "MACOSX_DEPLOYMENT_TARGET=10.5")
    set (MU_PLATFORM_DYLIB_EXTENSION "dylib")
else()
    set (MU_LD_LIBRARY_VAR "LD_LIBRARY_PATH")
    set (MU_PLATFORM_SPECIFIC_ENV "")
    set (MU_PLATFORM_DYLIB_EXTENSION "so")
endif()

# Initialize environment variables string to use for commands.
set (MU_BIN_PATH     ${MU_BIN_DIR}:$ENV{PATH})
set (MU_LIB_PATH     ${MU_LIB_DIR}:$ENV{${MU_LD_LIBRARY_VAR}})
set (MU_ENV_STRING   env PATH=${MU_BIN_PATH} ${MU_LD_LIBRARY_VAR}=${MU_LIB_PATH} ${MU_PLATFORM_SPECIFIC_ENV})
#set (MU_LDFLAGS      "-L${MU_LIB_DIR}")
set (MU_LDFLAGS      "-Wl,-rpath,${MU_LIB_DIR} -L${MU_LIB_DIR}")
#set (MU_LDFLAGS      "-Wl,-rpath,\$${ORIGIN}/../lib -L${MU_LIB_DIR}")

# All library builds should go to BPD/lib
set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY  ${MU_LIB_DIR})
set (CMAKE_LIBRARY_OUTPUT_DIRECTORY  ${MU_LIB_DIR})
set (CMAKE_RUNTIME_OUTPUT_DIRECTORY  ${MU_BIN_DIR})

# Set standard include directories.
include_directories (BEFORE ${MU_INCLUDE_DIR})

# Set optimization flags
set (MU_OPT_FLAGS    "-march=native -O3")

endif (NOT MU_ENV_STRING)
