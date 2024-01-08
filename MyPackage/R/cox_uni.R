cox_uni <- function(object){
  # The form of object is as follows:
  #     1      2        3
  # 1  time  status  variable
  # 2


  # Store univariate cox results, the next step is the forest map

  # The form of res is as follows:
  #     1             2       3       4           5
  #   "variable"  "p-value" "HR"  "lower.95"  "upper.95"
  # 1  var1
  # 2  var2
  # 3  var3

  res <- matrix(,nrow = dim(object)[2]-2, ncol = 5,
                dimnames = list(NULL,
                                c("variable","p-value","HR","lower.95","upper.95")
                                )
                )

  # cox
  for(i in 3:dim(object)[2]){
    res_i <- summary(coxph(Surv(object[,1], object[,2]) ~ object[,i], data = object))
    res["variable", 1] <- colnames(object)[i]
    res["p-value", 2] <- res_i$coefficients[5]  # p-value
    res["HR", 3] <- res_i$coefficients[2]       # HR
    res["lower.95", 4] <- res_i$conf.int[3]     # lower.95
    res["upper.95", 5] <- res_i$conf.int[4]     # upper.95
  }

  return(res)
}
