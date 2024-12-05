#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>

i <- as.numeric(Sys.gentev("PBS_ARRAY_INDEX"))do_simulation(i)

#S