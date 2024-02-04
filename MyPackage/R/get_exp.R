get_exp <- function(GSE_name){
  # get the raw expression matrix from the "GSE_series_matrix.txt"

  library(data.table)
  library(magrittr)
  library(R.utils)

  # import the series matrix
  GSE_txt <- gunzip("GSE46862_series_matrix.txt.gz", remove = FALSE)
  GSE <- fread(GSE_txt, fill = TRUE)

  row_exp_mat_begin <- which(GSE == "!series_matrix_table_begin", arr.ind = TRUE)[, 1] + 1
  row_exp_mat_end <- which(GSE == "!series_matrix_table_end", arr.ind = TRUE)[, 1] - 1

  exp_df <- GSE[c(row_exp_mat_begin:row_exp_mat_end),]
  samples_id <- exp_df[1, -1] %>% unlist()
  probe_id <- exp_df[-1, 1] %>% unlist()
  exp_mat <- exp_df[-1, -1] %>% as.matrix()
  exp_mat <- apply(exp_mat, c(1,2), as.numeric) # convert to numeric value type

  exp_raw <- data.frame(probe_id, exp_mat) # the next step is preprocessing
  names(exp_raw) <- c("probe_id", samples_id)
  return(exp_raw)
}
