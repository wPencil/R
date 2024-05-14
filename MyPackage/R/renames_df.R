renames_df <- function(df, old_names, new_names){
  
  names(df)[names(df) == old_names] <- new_names
  return(df)
  
}
