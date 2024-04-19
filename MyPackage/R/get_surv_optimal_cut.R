get_surv_optimal_cut <- function(object, time0, event0, vari){

  res.cut <- surv_cutpoint(object,
                           time = time0,
                           event = event0,
                           variables = vari
                           )

  res.cat <- surv_categorize(res.cut)

  res.cat[,3] <- factor(res,cat[,3], levels = c(1,2), labels = c("low", "high"))

  return(res.cat)

  }


