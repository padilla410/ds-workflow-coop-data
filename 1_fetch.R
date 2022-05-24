#' THIS DOES NOT WORK RIGHT NOW
#' Write a function that is similar to `scipiper::gd_get`
#' grab list of files from googledrive, check hashes against local cache
#' update out-of-date hashes


p1_targets_list <- list(
  # https://books.ropensci.org/targets/targets.html#working-with-tools-outside-r
  # https://docs.ropensci.org/targets/reference/tar_cue.html
  
  tar_target(
    # list files in the repo, dribble contains hashes
    coop_file_list,
    drive_ls('ds-workflow-coop-data/1_fetch/data_cooperator/in')
  ),
  
  tar_target(
    coop_files_download_path,
    paste(path_coop_files, coop_file_list, sep = '/'),
    pattern = coop_file_list
  ),
  
  tar_target(
    coop_files_local,
    drive_download(coop_file_list, 
                   path = coop_files_download_path, 
                   overwrite = TRUE),
    pattern = map(coop_file_list, coop_files_download_path),
    repository = 'gcp'
  )
)

