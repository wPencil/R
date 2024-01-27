get_p_surv <- function(object){
  
  
  colnames(object) <- c("time", "status", "groups")
  
  
  surv_diff <- survdiff(Surv(time, status) ~ groups, data = object)
  
  (p.value <- 1 - pchisq(surv_diff$chisq, length(surv_diff$n) -1))
  
  
}
