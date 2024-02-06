get_exprs <- function(GSE_name) {

  # get the raw expression matrix from the "GSE_series_matrix.txt.gz"

  # 0. package------------------------------------------------------------------
  library(R.utils)

  GSE_txt <- gunzip(GSE_name, remove = FALSE)
  GSE_exprs <- read.table(GSE_txt, header = TRUE, comment.char = "!")
  # comment.char = "!": "!" followed by the contents of the comment, do not read

  rownames(GSE_exprs) <- GSE_exprs[, 1]
  GSE_exprs <- GSE_exprs[, -1]

  return(GSE_exprs)
}
