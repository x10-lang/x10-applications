import random
import sys
import math

if len(sys.argv) != 6:
    print "usage: Create_input.py nprocs lmean lstdv pmean pstdv"
    sys.exit(1)

nprocs = int(sys.argv[1])
lmean = float(sys.argv[2])
lstdv = float(sys.argv[3])
pmean = float(sys.argv[4])
pstdv = float(sys.argv[5])

print nprocs
for i in range(nprocs):
    l = random.gauss(lmean,lstdv)
    if l < .25:
        l=.25
    if l > .75:
        l=.75
    p = int(math.floor(random.gauss(pmean,pstdv)))
    print l,p

