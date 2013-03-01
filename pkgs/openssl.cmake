#
# Install openssl from source
#
# The OpenSSL Project is a collaborative effort to develop a robust,
# commercial-grade, full-featured, and Open Source toolkit implementing the
# Secure Sockets Layer (SSL v2/v3) and Transport Layer Security (TLS v1)
# protocols as well as a full-strength general purpose cryptography library.
#
# http://www.openssl.org/

if (NOT openssl_NAME)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

include (ExternalProject)
include (ExternalSource)
include (BuildSupport)

include (zlib)

external_source (openssl
    1.0.1e
    openssl-1.0.1e.tar.gz
    66bf6f10f060d561929de96f9dfe5b8c
    http://www.openssl.org/source)

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    # On Mac, 64-bit builds must be manually requested.
    set (SSL_CONFIGURE_COMMAND ./Configure darwin64-x86_64-cc )
else()
    # The config script seems to auto-select the platform correctly on linux
    # It calls ./Configure for us.
    set (SSL_CONFIGURE_COMMAND ./config)
endif()

message ("Installing ${openssl_NAME} into ${PROJECT_NAME} build area: ${MU_BUILD_DIR} ...")

ExternalProject_Add(${openssl_NAME}
    DEPENDS             ${zlib_NAME}
    PREFIX              ${MU_BUILD_DIR}
    URL                 ${openssl_URL}
    URL_MD5             ${openssl_MD5}
    UPDATE_COMMAND      ""
    PATCH_COMMAND       ""
    CONFIGURE_COMMAND   ${MU_ENV_STRING} ${SSL_CONFIGURE_COMMAND}
        --prefix=${MU_BUILD_DIR}
        --openssldir=${MU_BUILD_DIR}/etc/ssl
        -I${MU_INCLUDE_DIR}
        -L${MU_LIB_DIR}
        shared
        zlib
    BUILD_COMMAND       ${MU_ENV_STRING} make
    BUILD_IN_SOURCE     1
    TEST_COMMAND        ${MU_ENV_STRING} make test
    INSTALL_COMMAND     ${MU_ENV_STRING} make install
)

set_target_properties(${openssl_NAME} PROPERTIES EXCLUDE_FROM_ALL ON)

endif (NOT openssl_NAME)
