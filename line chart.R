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
test0 <- ChickWeight[1:12,] # Chick 1, Diet 1
ggplot(data = test0, mapping = aes(x=Time, y=weight))+
  geom_line()+
  geom_point()+
  theme_classic()+ # theme_gray() by default
  labs(title = "line chart", 
       #subtitle = "", 
       #x = "", y = ""
  )+
  theme(plot.title = element_text(hjust = 0.5))+ # title centered
  scale_x_continuous(breaks = unique(test$Time)) # show all x-axis ticks
ggsave("1.1_df_one_group.png", dpi = 500)

# 1.2 two group-----------------------------------------------------------------
test0 <- ChickWeight[1:24,] # Chick1, Diet 1 and 2
ggplot(data = test0, mapping = aes(x=Time, y=weight, color=Chick))+
  geom_line()+
  geom_point()+
  theme_classic()+ # theme_gray() by default
  scale_color_manual(values = c("red","darkblue"))+ # set group color
  labs(title = "line chart", 
       #subtitle = "", 
       #x = "", y = ""
       )+
  theme(plot.title = element_text(hjust = 0.5)) + # title centered 
  scale_x_continuous(breaks = unique(test0$Time))  # show all x-axis ticks
ggsave("1.2_df_two_group.png", dpi = 500)

# 2.Time series data------------------------------------------------------------
# 2.1 one variable--------------------------------------------------------------
set.seed(1)
value1 <- rnorm(12)
variable <- as.factor(rep(1,12))
df <- data.frame(date = seq(as.Date("2021-01-01"), as.Date("2021-12-31"), by = "month"),
                 value1,
                 variable)
df$date <- as.Date(df$date)

test0 <- df
ggplot(data = test0, mapping = aes(x=date, y=value1, color=variable))+
  geom_line()+
  geom_point()+
  theme_classic()+ # theme_gray() by default
  labs(title = "line chart", 
       #subtitle = "", 
       #x = "", y = ""
  )+
  theme(plot.title = element_text(hjust = 0.5))+ # title centered
  scale_x_continuous(breaks = unique(test0$date))  # show all x-axis ticks
ggsave("2.1_ts_one_group.png", width = 10,dpi = 500)

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

test0 <- df_l

ggplot(data = test0, mapping = aes(x=date, y=value, color=variable))+
  geom_line()+
  geom_point()+
  theme_classic()+ # theme_gray() by default
  scale_color_manual(values = c("red","darkblue"))+ # set group color
  labs(title = "line chart", 
       #subtitle = "", 
       #x = "", y = ""
  )+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_x_continuous(breaks = unique(test0$date)) # show all
ggsave("2.2_ts_two_group.png", width = 10, dpi = 500)

# function----------------------------------------------------------------------
line_chart <- function(test0, x0, y0, title0=NULL,groups0=NULL, colors0=NULL,
                       x_labs0=NULL, y_labs0=NULL, legend_title0=NULL){
  library(ggplot2)
  
  ggplot(data = test0, mapping = aes(x=x0, y=y0, color=groups0))+
    geom_line()+
    geom_point()+
    theme_classic()+ # theme_gray() by default
    scale_color_manual(values = colors0)+ # set group color
    labs(title = title0, # title 
         # subtitle = subtitle0,
         x = x_labs0,    # x-axis names
         y = y_labs0,    # y-axis names
         colour = legend_title0,
         )+
    theme(plot.title = element_text(hjust = 0.5))+
    scale_x_continuous(breaks = unique(x0)) # show all
}

line_chart(test0 = test0, x0 = test0$date, y0 = test0$value, 
           groups0=test0$variable,  # group 
           colors0=c("red","darkblue"), # group color
           title0 = "This is title",
           x_labs0 = "x-axis names",
           y_labs0 = "y-axis names",
           legend_title0 = "legend title"
           )
ggsave("line_chart_function.png", width = 10, dpi = 500)
