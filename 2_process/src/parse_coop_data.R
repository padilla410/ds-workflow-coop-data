library(tidyverse)
library(targets)

#source files
sapply(list.files('2_process/src/data_parsers', full.names = T), source)
source('lib/src/generic_utils.R')

files_coop <- list.files('1_fetch/in/coop', full.names = T)

parsers_coop <- list.files('1_fetch/in/coop', full.names = F) %>% 
  paste0('parse_', .) %>% 
  gsub('.xlsx', '', .)

parsing_table <- as_tibble(
  list(
    file_name = files_coop,
    parser_name = parsers_coop
  )
)

data_clean <- purrr::pmap(parsing_table, 
                          function(file_name, parser_name){
                            rlang::exec(parser_name, file_name)
                            })
