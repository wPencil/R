is_dup<- function(x){
  # Determine if there are duplicate elements, 
  # and return the names and numbers of duplicated elements
  
  # Input is a vector
  
  if(!(TRUE %in% duplicated(x))){
    return("Not duplicated elements")
  } else {
    dup <- x[duplicated(x)] # duplicated elements
    
    dup_num <- length(dup) # Numbers of duplicated elements
    
    dup_counts <- table(dup) # Number of occurrences of duplicated elements
    
  }

  # print-----------------------------------------------------------------------
  print("The Numbers of duplicated elements:")
  print(dup_num)
  
  print("The duplicated elements:")
  print(dup)
  
  print("The Number of occurrences of duplicated elements:")
  print(dup_counts)
}

