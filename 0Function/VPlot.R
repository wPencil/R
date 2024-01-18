VPlot <- function(gene, cell, filename, pattern, wid = 10){
  nrows = floor(length(gene) %/% 3)
  hei = 3 * nrows
  pdf(paste(filename, ".pdf", sep = ""),width = wid, height = hei)
  print(VlnPlot(cell, features = gene, pt.size = 0, ncol = 3)+ylim(0,10)+
          xlab("cell clusters")+guides(fill=F))
  dev.off()
}