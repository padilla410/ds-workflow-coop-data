#' @param infile full path for file to parse
#' @param outpath subfolder to store final RDS output. Do not include final `/`
parse_Indiana_Glacial_Lakes_WQ_IN_DNR <- function(infile, outpath = '2_process/tmp') {

  raw <- readxl::read_excel(infile)

  clean <- raw %>%
    filter(grepl('temp', Parameter, ignore.case = TRUE)) %>%
    mutate(IN_DNR_ID = paste("IN_DNR", Lake, County, sep = "_")) %>%
    rename('0' = Surface) %>%
    dplyr::select(-(Lake:County), -(Month:`Secchi (ft)`)) %>%
    tidyr::gather(key = 'depth', value = 'temp', -IN_DNR_ID, -Date) %>%
    mutate(temp = fahrenheit_to_celsius(temp),
           DateTime = as.Date(Date),
           depth = convert_ft_to_m(as.numeric(depth))) %>%
    dplyr::select(DateTime, depth, temp, IN_DNR_ID)
	
  # extract file name from `infile`
  file_name <- infile %>% 
    gsub('(\\..*)', '', .) %>% # remove file extension
    gsub('(^1_.*)(/)', '', .) # remove `in` file path
  
  # create outfile name
  out_nm <- paste0(outpath, '/', file_name, '.rds')
  
  saveRDS(object = clean, file = out_nm)
  return(out_nm)

}

#' @param infile full path for file to parse
#' @param outpath subfolder to store final RDS output. Do not include final `/`
parse_Indiana_CLP_lakedata_1994_2013 <- function(infile, outpath = '2_process/tmp') {

  raw <- readxl::read_excel(infile)

  clean <- raw %>%
    mutate(IN_CLP_ID = paste("IN_CLP_", Lake_ID, sep = ''),
           DateTime = as.Date(`Date Sampled`)) %>%
    dplyr::select(DateTime, IN_CLP_ID, `Temp-0`:`T-35`) %>%
    tidyr::gather(key = 'depth', value = 'temp', -IN_CLP_ID, -DateTime) %>%
    mutate(depth = gsub('.+-', '', depth)) %>%
    mutate(depth = as.numeric(gsub('_', '\\.', depth))) %>%
    filter(!is.na(temp)) %>%
    dplyr::select(DateTime, depth, temp, IN_CLP_ID)

  # extract file name from `infile`
  file_name <- infile %>% 
    gsub('(\\..*)', '', .) %>% # remove file extension
    gsub('(^1_.*)(/)', '', .) # remove `in` file path
  
  # create outfile name
  out_nm <- paste0(outpath, '/', file_name, '.rds')
  
  saveRDS(object = clean, file = out_nm)
  return(out_nm)
}

#' @param infile full path for file to parse
#' @param outpath subfolder to store final RDS output. Do not include final `/`
parse_Indiana_GlacialLakes_TempDOprofiles_5.6.13 <- function(infile, outpath = '2_process/tmp') {

  raw <- readxl::read_excel(infile)

  clean <- raw %>%
    mutate(id = paste(vaw_name, vaw_waterID, sep = '_'),
           DateTime = as.Date(samp_startdate)) %>%
    dplyr::select(DateTime, id, depth = flc_depth, temp = flc_watertemp) %>%
    mutate(depth = convert_ft_to_m(depth),
           temp = fahrenheit_to_celsius(temp)) %>%
    filter(!depth < 0)
    dplyr::select(DateTime, depth, temp, id)

    # extract file name from `infile`
    file_name <- infile %>% 
      gsub('(\\..*)', '', .) %>% # remove file extension
      gsub('(^1_.*)(/)', '', .) # remove `in` file path
    
    # create outfile name
    out_nm <- paste0(outpath, '/', file_name, '.rds')
    
    saveRDS(object = clean, file = out_nm)
    return(out_nm)

}
