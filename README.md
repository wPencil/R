# R  
做实验时遇到的一些问题及处理方案

# My function

## get_exp()
get_exp() is used to get the expression spectrum from a gz archive, for example GSE46862_series_matrix.txt.gz
```
exp <- get_exp(GSE_name = "GSE46862_series_matrix.txt.gz")

head(exp)
#     probe_id GSM1139299 GSM1139300 GSM1139301 GSM1139302 GSM1139303 GSM1139304 GSM1139305
# V11  7892501   3.963347   3.856160   3.467366   3.428338   5.581259   4.579268   4.185471
# V12  7892502   3.978277   3.939501   4.234637   3.692276   4.333034   3.966897   4.073275
# V13  7892503   3.290211   3.017717   3.304860   2.797594   2.646458   2.829106   2.975919
# V14  7892504   8.765769   9.635162   9.741877   8.823293   9.566590   9.619902   8.902657
# V15  7892505   2.949176   2.853672   3.700773   3.094294   3.025122   2.580542   2.768958
# V16  7892506   4.102330   3.281870   3.706087   3.749726   3.696270   2.955118   3.130440
```

## plot_survival_curve()

**Description**    
plot_survival_curve() is used to draw survival curve and save as tiff image(by default) or png image. Must specify time, status, groups

**Usage**
```
plot_survival_curve <- function(object, time, event, groups,
                         image_name = paste0("survival curve", format(Sys.time(), "%Y-%m-%d %H-%M-%S")),

                         xlab0="time", ylab0="Survival probability",
                         xlim0=NULL, break_x0=NULL,
                         legend_title0=NULL, legend_labs0=NULL,

                         legend_pos=c(1, 2), image_type = c("tiff", "png"))
```

**Arguments**    
legend_pos: 1 or 2. 1: show p-value in the upper right corner (default); 2: show p-value in the lower left corner

```
plot_survival_curve(object = lung, time = "time", event = "status", groups = "sex")
```
<img src="https://github.com/wPencil/R/assets/109512465/51722362-b66d-4637-93b8-14db23387651" width="500" height="500">

```
plot_survival_curve(object = lung, time = "time", event = "status", groups = "sex",

                    image_name = "survival curve of lung dataset",

                    xlab0 = "This is x-axis", ylab0 = "This is y-axis",
                    xlim0 = c(0,1200), break_x0 = 300,
                    legend_title0 = "This is title", legend_labs0 = c("Male=1", "Female=2")
                    )
```
<img src="https://github.com/wPencil/R/assets/109512465/16c09757-de96-4e8d-8c0d-b25068608a39" width="500" height="500">



## calc_rs()

The example is below, input data is a expression series, whose row is genes and column is samples
```
head(test)

#          GSM363205 GSM363115 GSM362970 GSM363354 GSM363039 GSM363209 GSM363344 GSM363271
# A2M      10.516280 13.095141 10.368471  8.871921 10.933905 12.981733 10.962049 10.449860
# NAT1      6.798629  5.141138  5.954068  4.154114  6.419760  5.701455  5.700981  4.982274
# NAT2      5.239217  5.169284  5.412547  3.832912  8.194903  4.130538  5.777550  3.798735
# SERPINA3 11.620990 12.573531 11.066839  4.142566 11.307068 12.570848 10.014946 11.898349

```
```
calc_rs(test)
#           risk_score
# GSM363205   13.48826
# GSM363115   13.03457
# GSM362970   13.43796
# GSM363354   13.85478
# GSM363039   13.48488
# GSM363209   12.51142

class(calc_rs(test))
# [1] "matrix" "array" 
```

