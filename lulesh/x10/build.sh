#x10c++ -report postcompile=1 -O -NO_CHECKS -o lulesh -d tmp-x10c++ *.x10
#x10c++ -report postcompile=1 -O -NO_CHECKS -o lulesh -d tmp-x10c++ luleshtest.x10 Domain.x10
x10c++ -report postcompile=1 -O -NO_CHECKS -o lulesh -d tmp-x10c++ Lulesh_serial.x10 Domain_serial.x10
#x10c++ -DEBUG=true -O -NO_CHECKS -o CoMD-serial -d tmp-x10c++ comd/*.x10
