# -*- coding: utf-8 -*-
"""
Created on Sun Mar  3 00:19:13 2013

@author: guillaume
"""

import sys
import argparse

def main():
    
    from .. import __version__

    p = argparse.ArgumentParser(
        description='mu is a tool for managing μPython environments and packages.'
    )
    p.add_argument(
        '-v', '--version',
        action='version',
        version='mu %s' % __version__,
    )

if __name__ == '__main__':
    main()