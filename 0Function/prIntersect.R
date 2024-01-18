prIntersect <- function(Marker, FCgene, cell.seu, pattern = 1){
  # input matrix
  gene2 <- c()
  if(pattern == 1){
      for(i in 1:dim(Marker)[2]){
    for (j in as.numeric(length(levels(cell@active.ident)))) {
      gene1 <- intersect(Marker[,i], FCgene$gene[which(FCgene$cluster == j)])
      gene2 <- c(gene1, gene2)
    }
  }
  }

  # input vector
  if(pattern == 2){
    for (j in 1:as.numeric(length(levels(cell@active.ident)))) {
      gene1 <- intersect(Marker, FCgene$gene[which(FCgene$cluster == j)])
      gene2 <- c(gene1, gene2)
    }
  }
  gene2 <- unique(gene2)
  return (gene2)
}