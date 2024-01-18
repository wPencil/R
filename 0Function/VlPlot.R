vlPlot <- function(gene, cell,filename, wid = 10){
  library(RColorBrewer)
  library(Seurat)
  library(ggplot2)
  
  nrows = ceiling((length(gene) %% 12) / 3)
  hei = 3 * nrows
  
  pp_list <- gene
  n_pdf=ceiling(length(pp_list) / 12) - 1##判断一页4张图，需要多少页pdf
  pdf("test1.pdf", width=wid, height=12)
  for (i in 1:n_pdf){
    new_list=pp_list[c(1:12)]
    pp_list=pp_list[-c(1:12)]
    print(VlnPlot(cell, features = new_list, pt.size = 0, ncol = 3)+ylim(0,10)+
            xlab("")+guides(fill=F))
    # 当list中存在的图数量>4时，把前4个给到画图的newlist中并在一页pdf画出来；最后在原始list删除这4个图
  }
  dev.off()
  pdf("test2.pdf",width = wid, height = hei)
  new_list=pp_list
  print(VlnPlot(cell, features = new_list, pt.size = 0, ncol = 3)+ylim(0,10)+
          xlab("")+guides(fill=F))
  # 当list中存在的图数量≤4时，整个list给到现在的newlist中并在一页pdf画出来
  dev.off()
  
  library(qpdf) 
  pdf_combine(c("test1.pdf","test2.pdf"),
              output = paste(filename, ".pdf", sep = ""))
  file.remove("test1.pdf")
  file.remove("test2.pdf")
  
}