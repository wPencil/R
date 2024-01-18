reso_num = function(x){
  library(clustree)
  library(ggplot2)
  sce <- FindClusters(object = x,resolution = c(seq(.1,1.5,.1)))
  print(clustree(sce@meta.data, prefix = "RNA_snn_res."))
}