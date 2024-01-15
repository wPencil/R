fig_cell_prop <- function(object, file_name,ylab0=NULL,test_method="wilcox"){
  # readme----------------------------------------------------------------------
  # the form of input data, object.the pheno is factor
  #       1         2         3         4
  #     names   sample_id   percent   pheno (column names)
  # 1

  # example as follow:
  # To test the different of the percent of cell type in R and NR
  # cell_type, sample_id, percent, pheno(R, NR)

  # rename the column names-----------------------------------------------------
  colnames(object) <- c("names", "sample_id", "percent", "pheno")

  # Statistic test, wilcox test or t test---------------------------------------
  if(test_method == "wilcox"){
    test_res <- wilcox_test(percent ~ pheno, data = object, distribution = "exact")
    xlab_text <- paste0(as.character(unique(object$names)),": P = ",round(pvalue(test_res),4))
  }

  if(test_method == "t"){
    test_res <- t.test(percent ~ pheno, data = object)
    xlab_text <- paste0(as.character(unique(object$names)),": P = ",round(test_res$p.value,4))
  }

  object$percent <- 100*object$percent
  ylab_text <- paste0("(%) of ", ylab0)

  tiff(file = paste0(file_name, ".boxplot.tiff"),
       width = 3000, height = 4000, units = "px", res = 1000)

  # Add jitter points and errors (mean_se)

  print(
    ggboxplot(object, x = "pheno", y = "percent", ylab=ylab_text,
              label.pos = "out", lab.nb.digits = 1, xlab=xlab_text, lab.size=3,
              add = c("jitter"), width=0.5, color="pheno",
              palette = c("#00AFBB", "#E7B800"), legend=NULL, shape = "pheno"))

  dev.off()

}
