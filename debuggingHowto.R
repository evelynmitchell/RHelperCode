# Something's broken, break out the debugging toolkit
# From http://www.statsblogs.com/2013/05/21/an-r-debugging-example/

# it's running too slow
# profile

# there's an error
source(safeOptions.R) # prepare to change options with soptions
#
#soptions(warn=1) # print warnings
soptions(warn=2) # turn warnings into errors

soptions(error=dump.frames)
#soptions(error=recover)
# hop into the debugger and examine the environments
#debugger()