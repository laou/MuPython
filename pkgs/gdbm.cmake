#
# Install gdbm from source
#
# GNU dbm (or GDBM, for short) is a library of database functions that use
# extensible hashing and work similar to the standard UNIX dbm. These routines
# are provided to a programmer needing to create and manipulate a hashed
# database.
#
# http://www.gnu.org.ua/software/gdbm/

if (NOT gdbm_NAME)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

include (ExternalProject)
include (ExternalSource)
include (BuildSupport)

external_source (gdbm
    1.10
    gdbm-1.10.tar.gz
    88770493c2559dc80b561293e39d3570
    ftp://ftp.gnu.org/gnu/gdbm)

message ("Installing ${gdbm_NAME} into ${PROJECT_NAME} build area: ${MU_BUILD_DIR} ...")

ExternalProject_Add(${gdbm_NAME}
    PREFIX              ${MU_BUILD_DIR}
    URL                 ${gdbm_URL}
    URL_MD5             ${gdbm_MD5}
    UPDATE_COMMAND      ""
    PATCH_COMMAND       ""
    CONFIGURE_COMMAND   ${MU_ENV_STRING} ${gdbm_SRC_DIR}/configure
        --prefix=${MU_BUILD_DIR}
        LDFLAGS=${MU_BUILD_LDFLAGS}
        CPPFLAGS=-I${MU_INCLUDE_DIR}
    BUILD_COMMAND       ${MU_ENV_STRING} make
    INSTALL_COMMAND     ${MU_ENV_STRING} make install
)

set_target_properties(${gdbm_NAME} PROPERTIES EXCLUDE_FROM_ALL ON)

endif (NOT gdbm_NAME)


