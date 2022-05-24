# targets
library(targets)
library(tarchetypes)

tar_option_set(packages = c(
  'tidyverse'                   # wrangle dbf and csv files
))

# setting options
options(tidyverse.quiet = TRUE)

# source('1_fetch.R')
source('2_process.R')
# source('3_visualize.R')
source('lib/src/generic_utils.R')

path_coop_files <- c('1_fetch/in/coop')

c(p2_targets_list)