get_cell_prop <- function(seu_obj){
  # 1-----------------------------------------------------------------------------
  # the type of every cell clusters identified
  cell_ident <- unique(seu_obj@active.ident)
  # cell_ident
  # [1] CD14+ Mono   B            Memory CD4 T NK           CD8 T        Naive CD4 T  FCGR3A+ Mono DC          
  # [9] Platelet    
  # Levels: Naive CD4 T CD14+ Mono Memory CD4 T B CD8 T FCGR3A+ Mono NK DC Platelet
  
  # the all barcodes of cells of every cell clusters identified
  cell_barcodes <- list()
  for (i in 1:length(cell_ident)) {
    onelist <- list(rownames(seu_obj@meta.data)[which(seu_obj@active.ident == cell_ident[i])]) ###
    names(onelist) <- cell_ident[i]
    cell_barcodes <- c(cell_barcodes, onelist)
  }
  
  # 2-----------------------------------------------------------------------------
  # the overall summary of the percent of cell clusters
  data <- data.frame(seu_obj@active.ident,seu_obj$orig.ident) # a good name is need
  cell_prop<-data.frame(prop.table(table(data[,1],data[,2]))) # calculate the percent
  colnames(cell_prop) <- c("cell_type", "subject", "percent")
  
  return(cell_prop)
  
  # What I finally get is as follow:
  #       1           2       3         (4)
  #   cell_type   subject   percent   (pheno)
  # 1
  # 2
} 
