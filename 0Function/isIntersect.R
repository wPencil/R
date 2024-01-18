isIntersect <- function(Marker, FC_top, FC_sig, cell, pattern = 1){
  if(pattern == 1){
        for(i in 1:dim(Marker)[2]){
      cat(colnames(Marker)[i], "与细胞群差异基因的交集基因", "\n")
      for (j in as.numeric(levels(cell@active.ident))) {
        cat("\t", "细胞群", j, "\n")
        top <- intersect(Marker[,i], FC_top$gene[which(FC_top$cluster == j)])
        sig <- intersect(Marker[,i], FC_sig$gene[which(FC_sig$cluster == j)])
        ing <- sig %in% top
        sig <- sig[!ing]
        cat("\t", top, "\n")
        cat("\t", sig, "\n")
      }
    }
  }

  if(pattern == 2){
    for (j in 1:as.numeric(length(levels(cell@active.ident)))) {
      cat("\t", "细胞群", j, "\n")
      top <- intersect(Marker, FC_top$gene[which(FC_top$cluster == j)])
      sig <- intersect(Marker, FC_sig$gene[which(FC_sig$cluster == j)])
      ing <- sig %in% top
      sig <- sig[!ing]
      cat("\t", top, "\n")
      cat("\t", sig, "\n")
    }
  }
}
    


# R中%in%用于判断前一个向量的元素是否在后一个向量中， 返回逻辑值。
# a <- c(3,1,8,9)
# b <- c(2, 3, 4, 8, 10)
# a %in% b
# 
# a[a %in% b] # a中有，b中也有
# a[!(a %in% b)] # a中有，b中没有
# 
# b[!(b %in% a)] # b中有，a中没有
