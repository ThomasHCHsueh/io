#!/usr/bin/env python
import sys
import yaml
import argparse
from util_stuff import *
from util_people import *

## paths to the yaml files
stuff_path  = '/Users/thomashsueh/Dev/io/stuff.yaml'
people_path = '/Users/thomashsueh/Dev/io/people.yaml'
config_path = '/Users/thomashsueh/Dev/io/config.yaml' 

def parse_args():
    parser = argparse.ArgumentParser(description="<< io: the ultimate productivity tool >>")

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
    ls_parser.add_argument ('--a',   action='store_true', help='list all "appointment"')
    ls_parser.add_argument ('--t',   action='store_true', help='list all "today"')
    ls_parser.add_argument ('--g',   action='store_true', help='list all "growth"')
    ls_parser.add_argument ('--c',   action='store_true', help='list all "completed"')
    ls_parser.add_argument ('--d',   action='store_true', help='list all "deleted"')

    del_parser.add_argument('del_idx_s', help='index of task to be deleted', type=str, nargs='+')
    
    done_parser.add_argument('done_idx_s', help='index of task that is completed', type=str, nargs='+')
    
    add_parser.add_argument('new_task_type', help='type of the new task; valid type from {a, fa, t, g}', type=str)
    add_parser.add_argument('new_task_name', help='name of the new task', type=str)
    add_parser.add_argument('new_task_time', help='time required to complete the new task', type=str)
    add_parser.add_argument("-when", help="specifiy YYYY-MM-DD of future appointment",
                            default="NA", type=str)

    addp_parser.add_argument('addp_name', help='name of the new contact', type=str)
    addp_parser.add_argument('addp_ping_freq', help='how many days between pings', type=int)
    addp_parser.add_argument('addp_ping_last', help='last date of ping; format=YYYY-MM-DD', type=str)

    return parser.parse_args()

def main():
    with open(config_path) as file:
        config = yaml.load(file, Loader=yaml.FullLoader)

    stuff  = StuffDB (stuff_path, people_path, config)
    
    args = parse_args()
    
    if args.mode == 'nxt':
        stuff.nxt(args.avail)
    elif args.mode == 'ls':
        ## scan people database and task database (fore future appt) and generate new appointments for today
        stuff.sync()            

        if args.la:
            stuff.print_la()
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
        stuff.delete(args.del_idx_s)
    elif args.mode == 'done':
        stuff.done(args.done_idx_s)
    elif args.mode == 'add':
        stuff.add(args.new_task_type, args.new_task_name, args.new_task_time, args.when)

    elif args.mode == 'lp':
        stuff.lp()
    elif args.mode == 'addp':
        stuff.addp(args.addp_name, args.addp_ping_freq, args.addp_ping_last)

if __name__ == "__main__":
    main()

