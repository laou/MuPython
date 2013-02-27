MuPython
========

The goal of MuPython is to provide a cross-platform build process for a scientific Python distribution.

This idea behind MuPYthon is to optimize Python for a given hardware configuration, notably its packages and dependencies related to scientific computing. For instance Numpy and Scipy can take advantages of optimized BLAS and LAPACK library. However building libraries from source can be sometime tricky, because of the potential depency hell and the fact that the compilation is platform dependent.

Building process is inspired by [buildem](https://github.com/janelia-flyem/buildem), a modular CMake-based system that leverages [CMake's ExternalProject](http://www.kitware.com/media/html/BuildingExternalProjectsWithCMake2.8.html) to simplify and automate a complex build process.

## It is just a start...

For now I am focusing on Linux and a limited number of packages...
