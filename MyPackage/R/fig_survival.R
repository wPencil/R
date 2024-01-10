fig_survival <- function(object, file_name, ylab0, xlab0, break_x0,
                         xlim0, legend_title0, legend_labs0, legend_pos=1){
  # readme----------------------------------------------------------------------
  # The format of input object. data.frame()
  #       1     2       3
  # 0    time  status  groups
  # 1
  # 2

  # Load packages---------------------------------------------------------------
  library(survival)
  library(survminer)

  # survfit()-------------------------------------------------------------------
  fit <- surv_fit(Surv(time, status) ~ groups, data = object)

  # cox-------------------------------------------------------------------------
  cox <- coxph(Surv(time, status) ~ groups, data = object)
  res <- summary(cox)
  x <- object$time

  # fig-------------------------------------------------------------------------
  if(legend_pos == 1){
    p<-ggsurvplot(fit,
                pval = TRUE, pval.coord = c(0.7*max(x), 1),
                pval.method = TRUE, pval.method.coord=c(0.4*max(x),1),
                risk.table = TRUE, risk.table.col = "strata",
                ggtheme = theme_linedraw(),
                palette = c("darkblue", "red"),
                legend.title = legend_title0,
                legend.labs = legend_labs0,
                xlab = xlab0, xlim = xlim0, break.x.by = break_x0,
                ylab = ylab0
                )

    p$plot <- p$plot+
      theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank())+
      theme(plot.title = element_text(hjust = 0.5))+
      annotate("text",x=0.7*max(x),y=0.91, label=paste0("HR(95%CI) = ", round(res$conf.int[1],2), "(",round(res$conf.int[3],2),"-", round(res$conf.int[4],2), ")" ))+ # add HR(95%CI)
      annotate("text",x=0.7*max(x),y=0.83, label=paste0("C-index = ", round(res$concordance[1],2))) # add C-index

    p$table <- p$table+
      theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank())
  }

  if(legend_pos == 2){
    p<-ggsurvplot(fit,
                  pval = TRUE, pval.coord = c(0.32*max(x), 0.18),
                  pval.method = TRUE, pval.method.coord=c(0.03*max(x),0.18),
                  risk.table = TRUE, risk.table.col = "strata",
                  ggtheme = theme_linedraw(),
                  palette = c("darkblue", "red"),
                  legend.title = legend_title0,
                  legend.labs = legend_labs0,
                  xlab = xlab0, xlim = xlim0, break.x.by = break_x0,
                  ylab = ylab0)

    p$plot <- p$plot+
      theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank())+
      theme(plot.title = element_text(hjust = 0.5))+
      annotate("text",x=0.3*max(x),y=0.09, label=paste0("HR(95%CI) = ", round(res$conf.int[1],2), "(",round(res$conf.int[3],2),"-", round(res$conf.int[4],2), ")" ))+ # add HR(95%CI)
      annotate("text",x=0.3*max(x),y=0.01, label=paste0("C-index = ", round(res$concordance[1],2))) # add C-index

    p$table <- p$table+
      theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank())
  }


  # Save as tiff image----------------------------------------------------------
  tiff(file_name, width = 4290, height = 4930, res = 1000)
  print(p)
  dev.off()
}
