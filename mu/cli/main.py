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
    
    args = p.parse_args()
    
    try:
        args.func(args, p)
    except Exception as e:
        print "An unexpected error has occurred, please consider sending the following traceback to the μPython GitHub issue tracker at https://github.com/laou/MuPython/issues"
        print
        exc_info = sys.exc_info()
        raise exc_info[1], None, exc_info[2]    
    

if __name__ == '__main__':
    main()