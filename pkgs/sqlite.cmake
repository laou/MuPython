#
# Install SQLite from source
#
# SQLite is a software library that implements a self-contained, serverless,
# zero-configuration, transactional SQL database engine. SQLite is the most
# widely deployed SQL database engine in the world. The source code for
# SQLite is in the public domain.
#
# http://www.sqlite.org/

if (NOT sqlite_NAME)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

include (ExternalProject)
include (ExternalSource)
include (BuildSupport)

external_source (sqlite
    3.7.15.2
    sqlite-autoconf-3071502.tar.gz
    bcb0ab0b5b30116b2531cfeef3c861b4
    http://www.sqlite.org)

message ("Installing ${sqlite_NAME} into ${PROJECT_NAME} build area: ${MU_BUILD_DIR} ...")

ExternalProject_Add(${sqlite_NAME}
    PREFIX              ${MU_BUILD_DIR}
    URL                 ${sqlite_URL}
    URL_MD5             ${sqlite_MD5}
    UPDATE_COMMAND      ""
    PATCH_COMMAND       ""
    CONFIGURE_COMMAND ${MU_ENV_STRING} ${sqlite_SRC_DIR}/configure 
        --prefix=${MU_BUILD_DIR}
        LDFLAGS=${MU_BUILD_LDFLAGS}
        CPPFLAGS=-I${MU_INCLUDE_DIR}
    BUILD_COMMAND       ${MU_ENV_STRING} make
    INSTALL_COMMAND     ${MU_ENV_STRING} make install
)

set_target_properties(${sqlite_NAME} PROPERTIES EXCLUDE_FROM_ALL ON)

endif (NOT sqlite_NAME)

