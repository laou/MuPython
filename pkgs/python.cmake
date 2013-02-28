#
# Install python from source
#
# Defines the following:
#    PYTHON_INCLUDE_PATH
#    PYTHON_EXE -- path to python executable

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

# We have the choice between python 2.7 and python 3.3
# See http://wiki.python.org/moin/Python2orPython3
#
# Default Python 2, as many packages haven't been ported (yet!) to Python 3
SET(PYTHON_VERSION "2.7" CACHE STRING "Python version included in the build")
SET_PROPERTY(CACHE PYTHON_VERSION PROPERTY STRINGS "2.7" "3.3")

if (NOT python_NAME)

include (ExternalProject)
include (ExternalSource)
include (BuildSupport)

#Python build finished, but the necessary bits to build these modules were not found:
#_bsddb             _curses            _curses_panel   
#_tkinter           bsddb185           bz2             
#dbm                dl                 gdbm            
#imageop            readline           sunaudiodev     
#To find the necessary bits, look in setup.py in detect_modules() for the module's name.

include (bzip2)
include (gdbm)
include (ncurses)
#include (openssl)   # without openssl, hashlib might have missing encryption methods
include (sqlite)
include (zlib)

if (PYTHON_VERSION STREQUAL "2.7")
    external_source (python
        2.7.3
        Python-2.7.3.tar.bz2
        c57477edd6d18bd9eeca2f21add73919
        http://www.python.org/ftp/python/2.7.3)
else (PYTHON_VERSION STREQUAL "3.3")
    external_source (python
        3.3.0
        Python-3.3.0.tar.bz2
        b3b2524f72409d919a4137826a870a8f
        http://www.python.org/ftp/python/3.3.0)
else ()
    message (FATAL_ERROR "ERROR: Invalid Python version: ${PYTHON_VERSION}")
endif ()

message ("Installing ${python_NAME} into ${PROJECT_NAME} build area: ${MU_BUILD_DIR} ...")

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    # On Mac, we build a "Framework" build which has all the power of a "normal" build, 
    #  plus it can be used from a native GUI.
    # See http://svn.python.org/projects/python/trunk/Mac/README
    set (PYTHON_BUILD_TYPE_ARG "--enable-framework=${MU_BUILD_DIR}/Frameworks")
    set (PYTHON_PREFIX ${MU_BUILD_DIR}/Frameworks/Python.framework/Versions/${PYTHON_VERSION})
else()
    # On linux, PYTHON_PREFIX is the same as the general prefix.
    set (PYTHON_BUILD_TYPE_ARG "--enable-shared")
    set (PYTHON_PREFIX ${MU_BUILD_DIR})
endif()

# Add explicitely ncurses include directory to CPPFLAGS
set (PYTHON_CPPFLAGS "-I${MU_INCLUDE_DIR}, -I/${MU_INCLUDE_DIR}/ncurses")

ExternalProject_Add(${python_NAME}
    DEPENDS             ${openssl_NAME} ${sqlite_NAME} ${zlib_NAME}
    PREFIX              ${MU_BUILD_DIR}
    URL                 ${python_URL}
    URL_MD5             ${python_MD5}
    UPDATE_COMMAND      ""
    PATCH_COMMAND       ""
    CONFIGURE_COMMAND   ${MU_ENV_STRING} ${python_SRC_DIR}/configure 
        --prefix=${MU_BUILD_DIR}
        ${PYTHON_BUILD_TYPE_ARG}
        CFLAGS=${MU_OPT_FLAGS}
        LDFLAGS=${MU_LDFLAGS}
        CPPFLAGS=${PYTHON_CPPFLAGS}
    BUILD_COMMAND       ${MU_ENV_STRING} make
    INSTALL_COMMAND     ${MU_ENV_STRING} make 
	PYTHONAPPSDIR=${MU_BIN_DIR}/${python_NAME} install
    BUILD_IN_SOURCE 1 # Required for Mac
)

set (PYTHON_INCLUDE_PATH ${PYTHON_PREFIX}/include/python${PYTHON_VERSION})
set (PYTHON_LIBRARY_FILE ${PYTHON_PREFIX}/lib/libpython${PYTHON_VERSION}.${MU_PLATFORM_DYLIB_EXTENSION})
set (PYTHON_EXE ${PYTHON_PREFIX}/bin/python)
set (MU_PYTHONPATH  ${PYTHON_PREFIX}/lib/python${PYTHON_VERSION}:${PYTHON_PREFIX}/lib/python${PYTHON_VERSION}/site-packages:${PYTHON_PREFIX}/lib)

set_target_properties(${python_NAME} PROPERTIES EXCLUDE_FROM_ALL ON)

endif (NOT python_NAME)

