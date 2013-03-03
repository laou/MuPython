# -*- coding: utf-8 -*-
"""
Created on Sat Mar  2 23:58:22 2013

@author: guillaume
"""

import sys
import versioneer

from distutils.core import setup

if sys.version[:3] != '2.7':
    raise Exception("mu is only meant for Python 2.7, current version: %s" %
                    sys.version[:3])

versioneer.versionfile_source = 'mu/_version.py'
versioneer.versionfile_build = 'mu/_version.py'
versioneer.tag_prefix = '' # tags are like 1.2.0
versioneer.parentdir_prefix = 'mu-' # dirname like 'myproject-1.2.0'

scripts = ['bin/mu']

setup(
    name = "mu",
    version=versioneer.get_version(),
    cmdclass=versioneer.get_cmdclass(),
    author = "Guillaume Lucas.",
    author_email = "guillaume.lucas@epfl.ch",
    license = "BSD",
    description = "package management tool",
    long_description = open('README.md').read(),
    packages = ['mu','mu.cli'],
    scripts = scripts,
)
