# Content-----------------------------------------------------------------------
# 1.example
# 2.my 

# 0. package---------------------------------------------------------------------
library(survival)
library(survminer)

# 1. survival analysis
# Sample data
head(lung)

fit <- survfit(Surv(time, status) ~ sex, data = lung) 

ggsurvplot(fit)
ggsave("Survival analysis.png", dpi = 500)

# 2. my-------------------------------------------------------------------------
test0 <- fit
time0 <- lung$time
ggsurvplot(test0,
           pval = TRUE, 
           pval.method = TRUE, pval.method.coord=c(0.77*max(time0),1),
           pval.title = "right",pval.coord = c(0.75*max(time0), 0.9), 
           risk.table = TRUE, 
           risk.table.col = "strata", 
           ggtheme = theme_classic(), 
           palette = c("darkblue", "red"), 
           legend.title = "legend title", 
           legend.labs = c("labs1", "labs2"),
           
           # xlim = c(0,10), break.x.by = 2, xlab = "Years", 
           # ylab = "Relapse-free survival probability" 
)
