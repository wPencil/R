# R  
做实验时遇到的一些问题及处理方案

# My function

## get_exp()
get_exp() is used to get the expression spectrum from a gz archive, for example GSE46862_series_matrix.txt.gz, and retuen a data frame
```
exp <- get_exp(GSE_name = "GSE46862_series_matrix.txt.gz")

head(exp)
#         GSM1139299 GSM1139300 GSM1139301 GSM1139302 GSM1139303 GSM1139304 GSM1139305 GSM1139306
# 7892501   3.963347   3.856160   3.467366   3.428338   5.581259   4.579268   4.185471   2.187057
# 7892502   3.978277   3.939501   4.234637   3.692276   4.333034   3.966897   4.073275   3.878290
# 7892503   3.290211   3.017717   3.304860   2.797594   2.646458   2.829106   2.975919   3.326424
# 7892504   8.765769   9.635162   9.741877   8.823293   9.566590   9.619902   8.902657   9.020293
# 7892505   2.949176   2.853672   3.700773   3.094294   3.025122   2.580542   2.768958   3.512194
# 7892506   4.102330   3.281870   3.706087   3.749726   3.696270   2.955118   3.130440   3.138364
```

## plot_survival_curve()

**Description**    
plot_survival_curve() is used to draw survival curve and save as tiff image(by default) or png image. 
Must specify time, status, groups.
The custom arguments: ①x axis name, ②y axis name, ③x axis scale and spacing, ④y axis scale and spacing, ⑤title name, ⑥group label, ⑦file type saved, tiff or png 

**Usage**
```
plot_survival_curve <- function(object, time, event, groups,
                         file_name = paste0("survival curve", format(Sys.time(), "%Y-%m-%d %H-%M-%S")),

                         x_lab = "time", y_lab = "Survival probability",
                         x_lim = NULL, break_x = NULL,
                         legend_title = NULL, legend_labs = NULL,

                         legend_pos=c(1, 2), file_type = c("tiff", "png"))
```

**Arguments**    
legend_pos: 1 or 2. 1: show p-value in the upper right corner (default); 2: show p-value in the lower left corner

```
plot_survival_curve(object = lung, time = "time", event = "status", groups = "sex")
```
<img src="https://github.com/wPencil/R/assets/109512465/51722362-b66d-4637-93b8-14db23387651" width="500" height="500">

```
plot_survival_curve(object = lung, time = "time", event = "status", groups = "sex",

                    file_name = "survival curve of lung dataset",

                    x_lab = "This is x-axis", y_lab = "This is y-axis",
                    x_lim = c(0,1200), break_x = 300,
                    legend_title = "This is title", legend_labs = c("Male=1", "Female=2")
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

## is_dup(x)
The input object is a vector
```
test <- c(1, 2, 2, 3, 4, 4, 4)

is_dup(test)
# [1] "The Numbers of duplicated elements:"
# [1] 3
# [1] "The duplicated elements:"
# [1] 2 4 4
# [1] "The Number of occurrences of duplicated elements:"
# dup
# 2 4 
# 1 2
```


