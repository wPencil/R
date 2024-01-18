pdf_FeaturePlot <- function(object, features, filename, reduction = "umap"){
  # ----------------------------------------------------------------------------
  # Draw a FeaturePlot of the input genes and output the pdf file
  # 1 page with 12 pictures
  # The default setting is umap
  
  # library --------------------------------------------------------------------
  library(RColorBrewer)
  library(qpdf) 
  
  # Setting parameters, etc.----------------------------------------------------
  nrows = ceiling((length(features) %% 12) / 3) 
  hei = 3 * nrows
  # Width of 10, 1 page pdf height of 3 * the number of lines
  pp_list <- features
  n_pdf=ceiling(length(pp_list) / 12) - 1 
  # Number of 12 pictures on 1 page
  
  # Draw and export pdf --------------------------------------------------------
  # test1.pdf
  pdf("test1.pdf", width=10, height=12)
  for (i in 1:n_pdf){
      new_list=pp_list[c(1:12)]
      pp_list=pp_list[-c(1:12)]
      print(FeaturePlot(object, features = new_list, 
                        cols = brewer.pal(8,"Reds"), 
                        ncol = 3, 
                        reduction = reduction))
  }
  dev.off()
  # test2.pdf
  pdf("test2.pdf",width = 10, height = hei)
      new_list=pp_list
      print(FeaturePlot(object, features = new_list, 
                        cols = brewer.pal(8,"Reds"), 
                        ncol = 3, 
                        reduction = reduction))
  dev.off()
  # output.pdf
  pdf_combine(c("test1.pdf","test2.pdf"),
              output = paste(filename, ".pdf", sep = ""))
  # Merge test1.pdf and test2.pdf into output.pdf
  file.remove("test1.pdf") 
  file.remove("test2.pdf")
  # remove test1.pdf and test2.pdf
}