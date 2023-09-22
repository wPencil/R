# Content-----------------------------------------------------------------------
# 1.example
# 2.my 

# 0. package---------------------------------------------------------------------
library(survival)
library(survminer)

# 1. survival analysis
# Sample data
head(lung)

table(lung$sex)
fit <- survfit(Surv(time, status) ~ sex, data = lung) 

ggsurvplot(fit,risk.table = T)
ggsave("Survival analysis.png", dpi = 500)

# 2. my plot--------------------------------------------------------------------
cox <- coxph(Surv(time, status) ~ sex, data = lung)
res <- summary(cox)
x <- lung$time

p<-ggsurvplot(fit,
           pval = TRUE, pval.coord = c(0.7*max(x), 1),
           pval.method = TRUE, pval.method.coord=c(0.4*max(x),1),
           risk.table = TRUE, risk.table.col = "strata",
           ggtheme = theme_linedraw(), 
           palette = c("darkblue", "red"), 
           legend.title = "Gender",
           legend.labs = c("Male", "Female"),
           xlab = "Time(days)", xlim = c(0,1000), break.x.by = 200, 
           ylab = "Survival probability"
           )
p$plot <- p$plot+
  theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank())+
  ggtitle("My Survival Plot")+
  theme(plot.title = element_text(hjust = 0.5))+
  annotate("text",x=0.7*max(x),y=0.91, label=paste0("HR(95%CI) = ", round(res$conf.int[1],2), "(",round(res$conf.int[3],2),"-", round(res$conf.int[4],2), ")" ))+
  annotate("text",x=0.7*max(x),y=0.83, label=paste0("C-index = ", round(res$concordance[1],2)))
p$table <- p$table+
  theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank())

png("My Survival analysis.png", width = 4290, height = 4930, res = 1000)
p
dev.off()

# 3. my loop--------------------------------------------------------------------
loop_survival_analysis <- function(object0, file_name, ylab0, xlab0, break_x0,
                                   xlim0, legend_title0, legend_labs0){
  library(survival)
  library(survminer)
  
  # survfit()-------------------------------------------------------------------
  fit <- surv_fit(Surv(time, status) ~ groups, data = object0) 
  
  # cox-------------------------------------------------------------------------
  cox <- coxph(Surv(time, status) ~ groups, data = object0)
  res <- summary(cox)
  x <- object0$time
  
  # fig-------------------------------------------------------------------------
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
    # ggtitle("My Survival Plot")+
    theme(plot.title = element_text(hjust = 0.5))+
    annotate("text",x=0.7*max(x),y=0.91, label=paste0("HR(95%CI) = ", round(res$conf.int[1],2), "(",round(res$conf.int[3],2),"-", round(res$conf.int[4],2), ")" ))+
    annotate("text",x=0.7*max(x),y=0.83, label=paste0("C-index = ", round(res$concordance[1],2)))
  p$table <- p$table+
    theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank())
  
  tiff(file_name, width = 4290, height = 4930, res = 1000)
  print(p)
  dev.off()
}
