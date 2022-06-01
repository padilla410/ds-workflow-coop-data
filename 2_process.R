source('2_process/src/build_parser_name.R')
source(list.files('2_process/src/data_parsers', full.names = T))

p2_targets_list <- list(
  tar_files(
    coop_files,
    list.files(path_coop_files, full.names = T)
  ),
  
  tar_target(
    # this could be included in the target above
    # also vectorize to the extent possible
    coop_parsers,
    build_parser_name(coop_files), 
    pattern = map(coop_files) # this creates a good bit of `targets` overhead
  ),

  # build parsing table
  tar_target(
    coop_parser_xwalk,
    tibble(source = coop_files,
           func = coop_parsers)
  ),
  
  # # add an assertion to check that all data sets have parsers
  # tar_assert_df(
  #   x
  #   msg = "One or more data sources is missing a parser"
  # ),
  
  # # check for existence of `tmp` file to store intermediary files
  # tar_???(
  #   x,
  #   y
  # ),
  
  # tar_target(
  #   parse_coop_dynamically,
  #   parse_Indiana_Glacial_Lakes_WQ_IN_DNR(coop_files[[1]])
  #   # pattern = map(input_parser_xwalk),
  #   # format = 'file'
  # )#,

  tar_target(
    parse_coop_dynamically,
    rlang::exec(coop_parser_xwalk$func, coop_parser_xwalk$source),
    pattern = map(coop_parser_xwalk),
    format = 'file'
  )#,
)