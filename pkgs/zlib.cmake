#
# Install zlib from source
#
# A Massively Spiffy Yet Delicately Unobtrusive Compression Library
# (Also Free, not to Mention Unencumbered by Patents)
#
# http://www.zlib.net/

if (NOT zlib_NAME)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

include (ExternalProject)
include (ExternalSource)
include (BuildSupport)

external_source (zlib
    1.2.7
    zlib-1.2.7.tar.gz
    60df6a37c56e7c1366cca812414f7b85
    http://zlib.net)

message ("Installing ${zlib_NAME} into ${PROJECT_NAME} build area: ${MU_BUILD_DIR} ...")

ExternalProject_Add(${zlib_NAME}
    PREFIX              ${MU_BUILD_DIR}
    URL                 ${zlib_URL}
    URL_MD5             ${zlib_MD5}
    UPDATE_COMMAND      ""
    PATCH_COMMAND       ""
    # zlib has a CMakeLists build, but it is broken on Mac OS X
    # Must use the configure script.
    CONFIGURE_COMMAND ${MU_ENV_STRING} ./configure 
        --prefix=${MU_BUILD_DIR}
        --64
    BUILD_COMMAND       ${MU_ENV_STRING} make
    BUILD_IN_SOURCE     1 # Configure script requires BUILD_IN_SOURCE
    INSTALL_COMMAND     ${MU_ENV_STRING} make install
)

set_target_properties(${zlib_NAME} PROPERTIES EXCLUDE_FROM_ALL ON)

endif (NOT zlib_NAME)

