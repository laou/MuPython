# -*- coding: utf-8 -*-

def create_parser(sub_parsers):
    p = sub_parsers.add_parser(
        'help',
        description = "Displays a list of available mu commands and their help strings.",
        help        = "Displays a list of available mu commands and their help strings.",
    )
    p.set_defaults(func=execute)


def execute(args, parser):
    parser.print_help()