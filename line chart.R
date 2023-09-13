# Mind map----------------------------------------------------------------------
# line chart
# 0.packages
# 1.Data frame data
#     1.1 one variable
#     1.2 two variable
# 2.Time series data
#     2.1 one variable
#     2.2 two variable
# function: line_chart()--------------------------------------------------------

# 0.packages--------------------------------------------------------------------
library(ggplot2)
library(magrittr)

# 1.Data frame data-------------------------------------------------------------
head(ChickWeight) #The impact of different diet types on the growth rate of chicks
# 1.1 one group-----------------------------------------------------------------
test <- ChickWeight[1:12,] # Chick 1, Diet 1
ggplot(data = test, mapping = aes(x=Time, y=weight))+
  geom_line()+
  geom_point()+
  theme_classic()+ # theme_gray() by default
  labs(title = "line chart", 
       #subtitle = "XXXXXXX", 
       #x = "XXXXX", y = "XXXXX"
  )+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_x_continuous(breaks = unique(test$Time))
# 1.2 two group-----------------------------------------------------------------
test <- ChickWeight[1:24,] # Chick1, Diet 1 and 2
ggplot(data = test, mapping = aes(x=Time, y=weight, color=Chick))+
  geom_line()+
  geom_point()+
  theme_classic()+ # theme_gray() by default
  scale_color_manual(values = c("red","darkblue"))+ # set group color
  labs(title = "line chart", 
       #subtitle = "XXXXXXX", 
       #x = "XXXXX", y = "XXXXX"
       )+
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = unique(test$Time)) # 

# 2.Time series data------------------------------------------------------------
# 2.1 one variable--------------------------------------------------------------
df <- data.frame(date = seq(as.Date("2021-01-01"), as.Date("2021-12-31"), by = "month"),
                 value = rnorm(12))
df$date <- as.Date(df$date)

test <- df
ggplot(data = test, mapping = aes(x=date, y=value))+
  geom_line()+
  geom_point()+
  theme_classic()+ # theme_gray() by default
  labs(title = "line chart", 
       #subtitle = "XXXXXXX", 
       #x = "XXXXX", y = "XXXXX"
  )+
  theme(plot.title = element_text(hjust = 0.5))

rm(list = ls())

# 2.2 two variable--------------------------------------------------------------
set.seed(1)
value1 <- rnorm(12)
set.seed(2)
value2 <- rnorm(12)
df <- data.frame(date = seq(as.Date("2021-01-01"), as.Date("2021-12-31"), by = "month"),
                 value1,
                 value2)
df$date <- as.Date(df$date)

# wide-format -> long-format
library(reshape2)
df_l <- melt(df, id.vars = "date")

test <- df_l

ggplot(data = test, mapping = aes(x=date, y=value, color=variable))+
  geom_line()+
  geom_point()+
  theme_classic()+ # theme_gray() by default
  scale_color_manual(values = c("red","darkblue"))+ # set group color
  labs(title = "line chart", 
       #subtitle = "XXXXXXX", 
       #x = "XXXXX", y = "XXXXX"
  )+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_x_continuous(breaks = unique(test$date)) # show all

# function----------------------------------------------------------------------
line_chart <- function(test, x0, y0, title0=NULL,groups0=NULL, colors0=NULL,
                       x_labs0=NULL, y_labs0=NULL, legend_title=NULL){
  library(ggplot2)
  
  ggplot(data = test, mapping = aes(x=x0, y=y0, color=groups0))+
    geom_line()+
    geom_point()+
    theme_classic()+ # theme_gray() by default
    scale_color_manual(values = colors0)+ # set group color
    labs(title = title0, 
         x = x_labs0, 
         y = y_labs0,
         colour = legend_title,
         )+
    theme(plot.title = element_text(hjust = 0.5))+
    scale_x_continuous(breaks = unique(x0)) # show all
}
line_chart(test, test$date, test$value, groups0=test$variable, colors0=c("red","blue"))
