data(myeloma)
head(myeloma)

# 1. Determine the optimal cutpoint of variables
res.cut <- surv_cutpoint(myeloma, time = "time", event = "event",
                         variables = c("DEPDC1", "WHSC1", "CRIM1"))
summary(res.cut)
# 2. Plot cutpoint for DEPDC1
# palette = "npg" (nature publishing group), see ?ggpubr::ggpar
plot(res.cut, "DEPDC1", palette = "npg")
# 3. Categorize variables
res.cat <- surv_categorize(res.cut)
head(res.cat)
# 4. Fit survival curves and visualize
library("survival")
fit <- survfit(Surv(time, event) ~DEPDC1, data = res.cat)
ggsurvplot(fit, data = res.cat, risk.table = TRUE, conf.int = TRUE)

# Testing my function-----------------------------------------------------------
tmp <- get_surv_optimal_cut(myeloma, time0 = "time", event0 = "event",
                            vari = c("DEPDC1", "WHSC1", "CRIM1"))
