MuPython
========

The goal of MuPython is to provide a cross-platform build process for a scientific Python distribution.

This idea behind MuPython is to optimize Python for a given hardware configuration, notably its packages and dependencies related to scientific computing. For instance Numpy and Scipy can take advantages of optimized BLAS and LAPACK libraries. However building libraries from source can be sometime tricky, because of the potential depency hell and the fact that the compilation is platform dependent.

Building process is inspired by [buildem](https://github.com/janelia-flyem/buildem), a modular CMake-based system that leverages [CMake's ExternalProject](http://www.kitware.com/media/html/BuildingExternalProjectsWithCMake2.8.html) to simplify and automate a complex build process.

# Installation

## Prerequisites

### Linux

#### Ubuntu

The following command line installs all required dependencies at once:
```bash
sudo apt-get install build-essential cmake cmake-qt-gui git
```
## Build

To build MuPython you can either run 'cmake' in command line or use 'cmake-gui'.
