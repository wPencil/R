select_pcs <- function(x, savefig = FALSE){
  # ----------------------------------------------------------------------------
  # A three criteria for determining PC thresholds
  # Cumulative contribution of principal components is greater than 90%
  # The contribution of the PC itself to the variance is less than 5%
  # The difference between two consecutive PCs is less than 0.1%
  
  # library --------------------------------------------------------------------
  library(ggplot2)
  library(magrittr)
  library(Seurat)
  
  # ----------------------------------------------------------------------------
  pct<-x[["pca"]]@stdev / sum( x[["pca"]]@stdev )*100
  # Determine percent of variation associated with each PC
  
  cumu <- cumsum(pct)
  # Calculate cumulative percents for each PC
  
  co1 <- which(cumu>90 & pct<5)[1]
  # Determine which PC exhibits cumulative percent greater than 90% and % 
  # variation associated with the PC as less then 5
  
  co2 <- sort(which((pct[1:length(pct) - 1] - pct[2:length(pct)]) > 0.1), decreasing = T)[1] + 1
  # last point where change of % of variation is more than 0.1%
  
  pcs <- min(co1, co2)
  # Minimun of the two calcuation
  
  plot_df <- data.frame(pct = pct,cumu = cumu,rank = 1:length(pct))
  # create a dataframe with values
  
  # draw fig--------------------------------------------------------------------
  ggplot(plot_df, aes(cumu, pct, label = rank, color = rank > pcs))+ 
    geom_text() +
    geom_vline(xintercept = 90, color = "grey")+ 
    geom_hline(yintercept = min(pct[pct > 5]), color = "grey") +
    theme_bw()
  if(savefig){
    ggsave("pca numbers.png", width = 15, height = 8)
  }
  
  # return----------------------------------------------------------------------
  return(pcs)
}







