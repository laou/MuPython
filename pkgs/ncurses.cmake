#
# Install ncurses from sources
#
# The Ncurses (new curses) library is a free software emulation of curses
# in System V Release 4.0, and more. It uses Terminfo format, supports pads
# and color and multiple highlights and forms characters and function-key
# mapping, and has all the other SYSV-curses enhancements over BSD Curses.
#
# http://www.gnu.org/software/ncurses/ncurses.html

if (NOT ncurses_NAME)

CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

include (ExternalProject)
include (ExternalSource)
include (BuildSupport)

external_source (ncurses
    5.9
    ncurses-5.9.tar.gz
    8cb9c412e5f2d96bc6f459aa8c6282a1
    http://ftp.gnu.org/pub/gnu/ncurses)

message ("Installing ${ncurses_NAME} into ${PROJECT_NAME} build area: ${MU_BUILD_DIR} ...")

ExternalProject_Add(${ncurses_NAME}
    PREFIX              ${MU_BUILD_DIR}
    URL                 ${ncurses_URL}
    URL_MD5             ${ncurses_MD5}
    UPDATE_COMMAND      ""
    PATCH_COMMAND       ""
    CONFIGURE_COMMAND   ${MU_ENV_STRING} ${ncurses_SRC_DIR}/configure
        --with-shared 
        --prefix=${MU_BUILD_DIR}
        LDFLAGS=${MU_BUILD_LDFLAGS}
        CPPFLAGS=-I${MU_INCLUDE_DIR}
    BUILD_COMMAND       ${MU_ENV_STRING} make
    INSTALL_COMMAND     ${MU_ENV_STRING} make install &&
                        ln -sf ncurses/curses.h ${MU_INCLUDE_DIR}/ncurses.h &&
                        ln -sf ncurses/panel.h ${MU_INCLUDE_DIR}/panel.h
)

set_target_properties(${ncurses_NAME} PROPERTIES EXCLUDE_FROM_ALL ON)

endif (NOT ncurses_NAME)
