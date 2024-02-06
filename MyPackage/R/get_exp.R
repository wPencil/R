get_exp <- function(GSE_name) {

  # get the raw expression matrix from the "GSE_series_matrix.txt.gz"
  
  library(R.utils)

  GSE_txt <- gunzip(GSE_name, remove = FALSE)
  GSE_exp <- read.table(GSE_txt, header = TRUE, comment.char = "!")
  # comment.char = "!": "!" followed by the contents of the comment, do not read

  rownames(GSE_exp) <- GSE_exp[, 1]
  GSE_exp <- GSE_exp[, -1]

  return(GSE_exp)
}
