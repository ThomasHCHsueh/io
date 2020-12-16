#!/usr/bin/env python
import sys
import yaml
import argparse
from util import *
from util2 import *

with open(r'/Users/thomashsueh/Dev/pro/people.yaml') as file:
    people = yaml.load(file, Loader=yaml.FullLoader) # FullLoader converts yaml scalar values to Python dictionaries
with open(r'/Users/thomashsueh/Dev/pro/stuff.yaml') as file:
    stuff = yaml.load(file, Loader=yaml.FullLoader) # FullLoader converts yaml scalar values to Python dictionaries

def parse_args():
    parser = argparse.ArgumentParser(description="<< pro: the ultimate productivity tool for Thomas >>")

    ### stuff's parsers
    ss = parser.add_subparsers(dest='mode')
    nxt_parser  = ss.add_parser('nxt',  help='next task')
    ls_parser   = ss.add_parser('ls',   help='list tasks')
    del_parser  = ss.add_parser('del',  help='delete task')
    done_parser = ss.add_parser('done', help='completed task')
    add_parser  = ss.add_parser('add',  help='add task')
    lp_parser   = ss.add_parser('lp',   help='list people')
    addp_parser = ss.add_parser('addp', help='add people')

    nxt_parser.add_argument('avail', help='available time for the next task', type=int)
    
    ls_parser.add_argument ('--la',  action='store_true', help='list all tasks')
    ls_parser.add_argument ('--laa', action='store_true', help='list all tasks including "completed" and "deleted"')
    ls_parser.add_argument ('--a',   action='store_true', help='list all "appointment"')
    ls_parser.add_argument ('--t',   action='store_true', help='list all "today"')
    ls_parser.add_argument ('--g',   action='store_true', help='list all "growth"')
    ls_parser.add_argument ('--c',   action='store_true', help='list all "completed"')
    ls_parser.add_argument ('--d',   action='store_true', help='list all "deleted"')

    del_parser.add_argument('del_idx_s', help='index of task to be deleted', type=str, nargs='+')
    
    done_parser.add_argument('done_idx_s', help='index of task that is completed', type=str, nargs='+')
    
    add_parser.add_argument('new_task_type', help='type of the new task', type=str)
    add_parser.add_argument('new_task_name', help='name of the new task', type=str)
    add_parser.add_argument('new_task_time', help='time required to complete the new task', type=str)
    
    addp_parser.add_argument('addp_name', help='name of the new contact', type=str)
    addp_parser.add_argument('addp_ping_freq', help='how many days between pings', type=int)
    addp_parser.add_argument('addp_ping_last', help='last date of ping; format=YYYY-MM-DD', type=str)

    return parser.parse_args()

def main():
    stuff  = StuffDB ('/Users/thomashsueh/Dev/pro/stuff.yaml', '/Users/thomashsueh/Dev/pro/people.yaml')
    
    args = parse_args()
    
    if args.mode == 'nxt':
        stuff.nxt(args.avail)
    elif args.mode == 'ls':
        ## scan people database and generate new appointments for today
        stuff.sync_people()            

        if args.la:
            stuff.print_la()
        elif args.laa:
            stuff.print_laa()
        elif args.a:
            stuff.print_('appointment')
        elif args.t:
            stuff.print_('today')
        elif args.g:
            stuff.print_('growth')
        elif args.c:
            stuff.print_('done')
        elif args.d:
            stuff.print_('deleted')
        else:
            stuff.print_la() # default
    elif args.mode == 'del':
        print('move item in the stuff list to del')
    elif args.mode == 'done':
        stuff.done(args.done_idx_s)
    elif args.mode == 'add':
        stuff.add(args.new_task_type, args.new_task_name, args.new_task_time)

    elif args.mode == 'lp':
        stuff.lp()
    elif args.mode == 'addp':
        stuff.addp(args.addp_name, args.addp_ping_freq, args.addp_ping_last)

if __name__ == "__main__":
    main()

