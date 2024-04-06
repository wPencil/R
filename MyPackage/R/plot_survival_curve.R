plot_survival_curve <- function(object, time, event, groups,
                         file_name = paste0("survival curve", format(Sys.time(), "%Y-%m-%d %H-%M-%S")),

                         x_lab = "time", y_lab = "Survival probability",
                         x_lim = NULL, break_x = NULL,
                         legend_title = NULL, legend_labs = NULL,

                         legend_pos=c(1, 2), file_type = c("tiff", "png")) {
  # 0. readme-------------------------------------------------------------------

  # 1. Load packages------------------------------------------------------------
  library(survival)
  library(survminer)

  # 2. The dataset for survival analysis----------------------------------------
  surv_obj <- data.frame(time = object[, time],
                         event = object[, event],
                         groups = object[, groups])

  # 3.1 survfit()---------------------------------------------------------------
  fit <- surv_fit(Surv(time, event) ~ groups, data = surv_obj)

  # 3.2 cox---------------------------------------------------------------------
  cox <- coxph(Surv(time, event) ~ groups, data = surv_obj)
  res <- summary(cox)
  x <- surv_obj$time

  # 4. fig----------------------------------------------------------------------
  legend_pos <- match.arg(arg = NULL, legend_pos)

  # 4.1 legend_pos = 1----------------------------------------------------------
  # show p-value in the upper right corner (default)
  if (legend_pos == 1) {
    p <- ggsurvplot(fit,
                  pval = TRUE, pval.coord = c(0.7*max(x), 1),
                  pval.method = TRUE, pval.method.coord = c(0.4*max(x),1),
                  risk.table = TRUE, risk.table.col = "strata",
                  ggtheme = theme_linedraw(),
                  palette = c("darkblue", "red"),
                  legend.title = legend_title,
                  legend.labs = legend_labs,
                  xlab = x_lab, xlim = x_lim, break.x.by = break_x,
                  ylab = y_lab
                  )

    p$plot <- p$plot+
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
      theme(plot.title = element_text(hjust = 0.5))+
      annotate("text", x=0.7*max(x), y=0.91, label=paste0("HR(95%CI) = ", round(res$conf.int[1],2), "(",round(res$conf.int[3],2), "-", round(res$conf.int[4],2), ")" ))+ # add HR(95%CI)
      annotate("text", x=0.7*max(x), y=0.83, label=paste0("C-index = ", round(res$concordance[1],2))) # add C-index

    p$table <- p$table+
      theme(panel.grid.major=element_blank(), panel.grid.minor=element_blank())
  }

  # 4.2 legend_pos = 2----------------------------------------------------------
  # show p-value in the lower left corner
  if( legend_pos == 2 ){
    p<-ggsurvplot(fit,
                  pval = TRUE, pval.coord = c(0.32*max(x), 0.18),
                  pval.method = TRUE, pval.method.coord = c(0.03*max(x), 0.18),
                  risk.table = TRUE, risk.table.col = "strata",
                  ggtheme = theme_linedraw(),
                  palette = c("darkblue", "red"),
                  legend.title = legend_title,
                  legend.labs = legend_labs,
                  xlab = x_lab, xlim = x_lim, break.x.by = break_x,
                  ylab = y_lab)

    p$plot <- p$plot+
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
      theme(plot.title = element_text(hjust = 0.5))+
      annotate("text",x = 0.32*max(x), y = 0.09, label = paste0("HR(95%CI) = ", round(res$conf.int[1], 2), "(",round(res$conf.int[3], 2),"-", round(res$conf.int[4], 2), ")" ))+ # add HR(95%CI)
      annotate("text",x = 0.3*max(x), y = 0.01, label = paste0("C-index = ", round(res$concordance[1], 2))) # add C-index

    p$table <- p$table+
      theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
  }

  print(p)

  # 5. Save as tiff/png image, default is tiff format---------------------------
  file_type <- match.arg(arg = NULL, file_type)

  # 5.1 Save as tiff image------------------------------------------------------
  if (file_type == "tiff") {
    tiff(paste0(file_name,".tiff"), width = 4290, height = 4930, res = 1000)
    print(p)
    dev.off()
  }

  # 5.2 Save as png image-------------------------------------------------------
  if (file_type == "png") {
    png(paste0(file_name,".png"), width = 4290, height = 4930, res = 1000)
    print(p)
    dev.off()
  }
}

