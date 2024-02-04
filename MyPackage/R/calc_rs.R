calc_rs <- function(object){

  # readme----------------------------------------------------------------------
  # Calculating the risk score of cox model

  # package---------------------------------------------------------------------
  library(magrittr)

  # Import the risk model-------------------------------------------------------
  data("risk_model") # risk model

  # 1. Component genes and corresponding coefficients of the risk model---------
  gene <- coef(risk_model) %>% as.matrix()
  colnames(gene) <- "coef_gene" # Setting the colname

  # 2. Intersection of expression profiles and genes for risk model-------------
  gene_intersect <- rownames(gene)[rownames(gene) %in% rownames(object)]

  # 3. Only keep the intersection gene in risk model and expression profiles----
  gene <- gene[match(gene_intersect, rownames(gene)),] %>% as.matrix()
  colnames(gene) <- "coef_gene" # Setting the colname
  object <- object[match(gene_intersect, rownames(object)),]

  # 4. Lastly, calculate the risk score-----------------------------------------
  risk_score <- apply(object, 2,
                      function(x){ sum(gene[,"coef_gene"]*x) }
                      ) %>% as.matrix()
  colnames(risk_score) <- "risk_score"

  # object that the risk score is calculated correctly
  # sum(gene[1,1]*object[1,1] + gene[2,1]*object[2,1] + gene[3,1]*object[3,1] + gene[4,1]*object[4,1]) + gene[5,1]*object[5,1] + gene[6,1]*object[6,1]

  return(risk_score)
}
