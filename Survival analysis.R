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

ggsurvplot(fit)
ggsave("Survival analysis.png", dpi = 500)

# 2. my-------------------------------------------------------------------------
cox <- coxph(Surv(time, status) ~ sex, data = lung)
res <- summary(cox)
x <- lung$time

p<-ggsurvplot(fit,
           pval = TRUE, pval.coord = c(0.8*max(x), 1),
           pval.method = TRUE, pval.method.coord=c(0.65*max(x),1),
           risk.table = TRUE, risk.table.col = "strata",
           ggtheme = theme_classic(), 
           palette = c("darkblue", "red"), 
           legend.title = "Gender",
           legend.labs = c("Male", "Female"),
           xlab = "Time(days)", xlim = c(0,1000), break.x.by = 200, 
           ylab = "Survival probability"
           )
p$plot <- p$plot+
  ggtitle("My Survival Plot")+
  theme(plot.title = element_text(hjust = 0.5))+
  annotate("text",x=0.8*max(x),y=0.92, label=paste0("HR(95%CI) = ", round(res$conf.int[1],2), "(",round(res$conf.int[3],2),"-", round(res$conf.int[4],2), ")" ))+
  annotate("text",x=0.8*max(x),y=0.84, label=paste0("C-index = ", round(res$concordance[1],2)))

png("My Survival analysis.png", width = 7500, height = 6000, res = 1000)
p
dev.off()
