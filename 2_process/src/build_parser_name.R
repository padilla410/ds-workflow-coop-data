build_parser_name <- function(x) {
  # capture everything between the final `/` 
  # and the final file extension (e.g., `.xlsx`)
  
  # https://stackoverflow.com/questions/21200514/regular-expression-matching-vs-capturing
  x <- str_match(x, '^(?:[^/]*/){3}(.*)\\.')[1,2]
  paste('parse', x, sep = '_')
  
}

