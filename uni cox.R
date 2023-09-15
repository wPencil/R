uni_cox <- function(test0){
  # Store univariate cox results
  res <- matrix(,nrow = dim(test0)[2]-2, ncol = 5, 
                dimnames = list(NULL,
                                c("variable","p-value","HR","lower.95","upper.95")
                                )
                )
  
  # cox
  for(i in 3:dim(test0)[2]){
    res_i <- summary(coxph(Surv(test0[,1], test0[,2]) ~ test0[,i], data = test0))
    res[i-2,1] <- colnames(test0)[i]
    res[i-2,2] <- res_i$coefficients[5] # p-value
    res[i-2,3] <- res_i$coefficients[2] # HR
    res[i-2,4] <- res_i$conf.int[3]     # lower.95
    res[i-2,5] <- res_i$conf.int[4]     # upper.95
  }
  
  return(res_uni)
}
