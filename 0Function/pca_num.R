pca_num = function(x){
  library(ggplot2)
  library(magrittr)
  library(Seurat)
  ElbowPlot(x, ndims = 50)
  pct<-x[["pca"]]@stdev/sum(x[["pca"]]@stdev)*100
  cumu <- cumsum(pct)
  co1 <- which(cumu>90&pct<5)[1]
  co2 <- sort(which((pct[1:length(pct) - 1] - pct[2:length(pct)]) > 0.1), decreasing = T)[1] + 1
  pcs <- min(co1, co2)# pcs 确定的最佳主成分数
  plot_df <- data.frame(pct = pct,cumu = cumu,rank = 1:length(pct))
  
  print(
    ggplot(plot_df, aes(cumu, pct, label = rank, color = rank > pcs))+ 
      geom_text() +geom_vline(xintercept = 90, color = "grey")+ 
      geom_hline(yintercept = min(pct[pct > 5]), color = "grey")+theme_bw()
  )
}