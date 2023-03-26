#!/usr/bin/env python

""" Binary takes flag as input and has a ton of branches that perform arithmetic operations on input.
    Would be impossible to do manually, but angr can do it with no issues.  Just tell it what the 
    desired end state is (func that prints success msg) and it'll figure out what input is required
    to get there
    """
    
import angr

proj = angr.Project("cave", auto_load_libs=False)
init = proj.factory.entry_state()
sm = proj.factory.simulation_manager(init)

avoid = 0x401ac1  # addr of failure message
find = 0x401ab3   # addr of success message

# find state that reaches success message
sm.explore(find=find, avoid=avoid)

# print stdin that reached this state
found = sm.found[0]
print(found.posix.dumps(0))

# HTB{H0p3_u_d1dn't_g3t_th15_by_h4nd,1t5_4_pr3tty_l0ng_fl4g!!!}

