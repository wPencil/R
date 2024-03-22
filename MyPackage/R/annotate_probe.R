annotate_probe <- function(exp, anno, seq_grep = "/"){
  # readme----------------------------------------------------------------------
  # exp
  # data.frame()
  # The first column is the probe id, the others are data
  #     1         2      3
  #   probe_id  gene1  gene2  (column names)
  # 1
  # 2

  # anno
  # Annotation SOFT table.
  # The first column is the probe id, the second column is the gene id
  # data.frame()
  #     1         2
  #   probe_id  gene_id (column names)
  # 1


  # seq_grep
  # Separator for multiple genes on probes in the annotation file

  #-----------------------------------------------------------------------------
  colnames(anno) <- c("probe_id", "gene_id")
  colnames(exp)[1] <- "probe_id"
  if(class(exp[,2]) != "numeric"){
    exp[,-1] <- apply(exp[,-1], c(1,2), as.numeric)
  }

  # 1.Removal of empty probes---------------------------------------------------
  anno <- anno[-which(anno$gene_id == ""),]


  # 2.Removal of probes that detect multiple genes------------------------------
  anno <- anno[-grep(seq_grep, anno$gene_id),]

  # 3.Multiple probes for the same gene, averaged-------------------------------

  # 3.1 Intersection of annotation file and expression spectrum probe id
  probe_intersect <- intersect(anno$probe_id, exp$probe_id)

  # 3.2 Make the annotation file and expression profile probe id order consistent
  anno <- anno[match(probe_intersect, anno$probe_id),]
  exp <- exp[match(probe_intersect, exp$probe_id),]
  exp$probe_id <- anno$gene_id
  colnames(exp)[1] <- "gene_id"

  # 3.3 Calculate average
  exp <- aggregate(exp, by = list(exp$gene_id), FUN = mean)
  rownames(exp) <- exp$Group.1
  exp <- exp[,-c(1,2)]

  return(exp)
}
