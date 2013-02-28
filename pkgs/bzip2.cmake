#
# Install bzip2 from source
#
# bzip2 is a freely available, patent free, high-quality data compressor.
#
# http://www.bzip.org/

# FIXME: set -fPIC to be able to create the shared library

if (NOT bzip2_NAME)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

include (ExternalProject)
include (ExternalSource)
include (BuildSupport)

external_source (bzip2
    1.0.6
    bzip2-1.0.6.tar.gz
    00b516f4704d4a7cb50a1d97e6e8e15b
    http://www.bzip.org/1.0.6)

message ("Installing ${bzip2_NAME} into ${PROJECT_NAME} build area: ${MU_BUILD_DIR} ...")

ExternalProject_Add(${bzip2_NAME}
    DEPENDS             ""
    PREFIX              ${MU_BUILD_DIR}
    URL                 ${bzip2_URL}
    URL_MD5             ${bzip2_MD5}
    UPDATE_COMMAND      ""
    PATCH_COMMAND       patch < ${MU_REPO_DIR}/patches/bzip2-1.0.6-Makefile.patch # Patch Makefile in order to correctly build bzip2 shared library (using -fPIC)
    CONFIGURE_COMMAND   ""
    BUILD_COMMAND       ${MU_ENV_STRING} make CC=${CMAKE_C_COMPILER} && ${MU_ENV_STRING} make -f Makefile-libbz2_so CC=${CMAKE_C_COMPILER}
    BUILD_IN_SOURCE     1
    INSTALL_COMMAND     pwd && ${MU_ENV_STRING} make PREFIX=${MU_BUILD_DIR} install
)

# Install shared library
ExternalProject_add_step(${bzip2_NAME}  install_shared
    DEPENDEES   install
    COMMAND     pwd &&
                install -m755 ${bzip2_SRC_DIR}/libbz2.so.1.0.6 ${MU_LIB_DIR}/libbz2.so.1.0.6  &&
                ln -sf libbz2.so.1.0.6 ${MU_LIB_DIR}/libbz2.so.1.0 &&
                ln -sf libbz2.so.1.0.6 ${MU_LIB_DIR}/libbz2.so.1 &&
                ln -sf libbz2.so.1.0.6 ${MU_LIB_DIR}/libbz2.so
    COMMENT     "Install bzip2 shared library"
)

# Fix symbolic links of bzip2 binaries (absolute->relative)
ExternalProject_add_step(${bzip2_NAME}  fix_link
    DEPENDEES   install_shared
    COMMAND     ln -sf bzmore ${MU_BIN_DIR}/bzless &&
                ln -sf bzgrep ${MU_BIN_DIR}/bzfgrep && 
                ln -sf bzgrep ${MU_BIN_DIR}/bzegrep &&
                ln -sf bzdiff ${MU_BIN_DIR}/bzcmp
    COMMENT     "Fix symbolic links of bzip2 binaries (absolute->relative)"
)

set_target_properties(${bzip2_NAME} PROPERTIES EXCLUDE_FROM_ALL ON)

endif (NOT bzip2_NAME)

