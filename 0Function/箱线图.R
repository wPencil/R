
Singlecellratio_plotstat <- function (seu, by = "cell.type",meta.include = NULL, 
                                      group_by = NULL, shape_by = NULL,
                                      custom_fill_colors = NULL, group_by.point = NULL, color_by = NULL, 
                                      pb = FALSE, comparisons = my_comparisons, 
                                      ncol = NULL, label = c("p.format","p.signif"), 
                                      label.x = NA, pt.size = NA) 
{#关于shape的定义
  
  by <- match.arg(by)  
  if (is.null(group_by)){ #如果没有定义group.by,返回null.group
    group_by <- "null.group" 
  } 
  shapes <- NULL 
  if (!is.null(shape_by)) {#如果定义了group.by，那么shape选择
    shapes <- c(16,15,3,7,8,18,5,6,2,4,1,17)#shape选择
  }
  
  fq <- prop.table(table(seu@meta.data$cell_type, seu@meta.data[,"orig.ident"]), margin=2) *100#计算细胞比例，celltype如果你细胞类型命名是其他，请修改这里
  df <- reshape2::melt(fq, value.name = "freq", varnames = c("cell.type", "orig.ident"))  #宽数据转长数据
  
  uniques <- apply(seu@meta.data, 2, function(x) length(unique(x))) #查看metadata每一列的unique数
  ei <- unique(seu@meta.data[, names(uniques[uniques<=100])])
  ei <- unique(ei[,colnames(ei) %in% meta.include])
  df <- merge(df, ei, by = "orig.ident")
  df <- cbind(df, null.group = paste("1"))
  df$orig.ident <- as.factor(df$orig.ident)
  
  
  if (is.null(x = ncol)) {
    ncol <- 3
    
    if (length(unique(df$cell_type)) > 9) {
      ncol <- 4
    }
    if (length(unique(df$cell_type)) > 20) {
      ncol <- 5
    }
  }
  
  custom_fill_colors = c(RColorBrewer::brewer.pal(9, "Oranges")[2], 
                         RColorBrewer::brewer.pal(9, "Reds")[6:7], 
                         RColorBrewer::brewer.pal(9, "Oranges")[5:7], 
                         RColorBrewer::brewer.pal(9, "Blues")[4:9])
  
  
  
  p <- ggplot(df, aes_string(y = "freq", x = group_by)) + labs(x = NULL,y = "Proportion (%)") + theme_bw() + theme(panel.grid.minor = element_blank(), 
                                                                                                                   panel.grid.major = element_blank(), strip.background = element_rect(fill = NA, 
                                                                                                                                                                                       color = NA), 
                                                                                                                   strip.text = element_text(face = "bold", size = 14), 
                                                                                                                   axis.ticks.x = element_blank(), axis.text = element_text(color = "black"), 
                                                                                                                   axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5,color = 'black', size = 12),
                                                                                                                   axis.text.y = element_text(color = 'black', hjust = 1, vjust = 0.5, size = 12),
                                                                                                                   axis.title.y = element_text(color = 'black', size = 14))
  
  
  if(by=="cell.type" && color_by=="cell.type") {
    p + facet_wrap(group_by, scales = "free_x") + 
      geom_bar(aes_string(x = "orig.ident", fill = "factor(cell.type)"), position = "fill", stat = "identity") + 
      scale_fill_manual("cell.type", values = c("#FB8072", "#1965B0", "#7BAFDE", "#882E72","#B17BA6", 
                                                         "#FF7F00", "#FDB462", "#E7298A", "#E78AC3","#33A02C", 
                                                         "#B2DF8A", "#55A1B1", "#8DD3C7", "#A6761D","#E6AB02")) + 
                                                           scale_y_continuous(expand = c(0, 0), labels = seq(0, 100, 25)) + theme(panel.border = element_blank())
  }
  else {
    switch(by, cell.type = p + facet_wrap("cell.type", scales = "free_y", 
                                          ncol = ncol) + guides(fill = FALSE) + geom_boxplot(aes_string(x = group_by), 
                                                                                             alpha = 0.25, outlier.color = NA) + geom_point(size = 4, position = position_jitter(width = 0.25), 
                                                                                                                                            aes_string(x = group_by, y = "freq", color = color_by, 
                                                                                                                                                       shape = shape_by)) + scale_shape_manual(values = shapes) + 
             theme(panel.grid.major = element_line(color = "grey", 
                                                   size = 0.25)) + scale_color_manual(values = custom_fill_colors) + scale_fill_manual(values = custom_fill_colors)) + 
      scale_y_continuous(expand = expand_scale(mult = c(0.05, 0.2)))+
      ggpubr::stat_compare_means(mapping = aes_string(group_by), comparisons = comparisons, label = label,method = "t.test")
  }
  
}












