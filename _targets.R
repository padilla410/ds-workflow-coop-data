# Targets
library(targets)
library(tarchetypes)

# Load internal libraries
tar_option_set(packages = c(
  'googledrive',                # access shared cache
  'tidyverse',                  # wrangle dbf and csv files
  'tools'                       # to check gd hashes against local hashes
))

# Set options
options(tidyverse.quiet = TRUE)

# Source a few generic utility functions
source('lib/src/generic_utils.R')

# Source phases
source('1_fetch.R')
source('2_process.R')
# source('3_visualize.R')

# Path variables - stored at top-level for easy modification
path_coop_files <- c('1_fetch/in/coop')

# Run targets
c(p1_targets_list) #, p2_targets_list)