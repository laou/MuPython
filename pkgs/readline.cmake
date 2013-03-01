#
# Install readlibe from source
#
# The GNU Readline library provides a set of functions for use by applications
# that allow users to edit command lines as they are typed in.
#
# http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html

if (NOT readline_NAME)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

include (ExternalProject)
include (ExternalSource)
include (BuildSupport)

external_source (readline
    6.2
    readline-6.2.tar.gz
    67948acb2ca081f23359d0256e9a271c
    ftp://ftp.cwru.edu/pub/bash)

message ("Installing ${readline_NAME} into ${PROJECT_NAME} build area: ${MU_BUILD_DIR} ...")

ExternalProject_Add(${readline_NAME}
    PREFIX              ${MU_BUILD_DIR}
    URL                 ${readline_URL}
    URL_MD5             ${readline_MD5}
    UPDATE_COMMAND      ""
    PATCH_COMMAND       patch -p0 < ${MU_REPO_DIR}/patches/readline-6.2-001.patch &&
                        patch -p0 < ${MU_REPO_DIR}/patches/readline-6.2-002.patch# &&
                        #patch -p0 < ${MU_REPO_DIR}/patches/readline-6.2-003.patch &&
                        #patch -p0 < ${MU_REPO_DIR}/patches/readline-6.2-004.patch
    CONFIGURE_COMMAND ${MU_ENV_STRING} ${readline_SRC_DIR}/configure
        --prefix=${MU_BUILD_DIR}
        LDFLAGS=${MU_BUILD_LDFLAGS}
        CPPFLAGS=-I${MU_INCLUDE_DIR}
    BUILD_COMMAND       ${MU_ENV_STRING} make
    INSTALL_COMMAND     ${MU_ENV_STRING} make install
)

set_target_properties(${readline_NAME} PROPERTIES EXCLUDE_FROM_ALL ON)

endif (NOT readline_NAME)

