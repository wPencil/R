# Mind map----------------------------------------------------------------------
# line chart
# 0.packages
# 1.Data frame data
#     1.1 one variable
#     1.2 two variable
# 2.Time series data
#     2.1 one variable
#     2.2 two variable

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
test1 <- ChickWeight[1:24,] # Chick1, Diet 1 and 2
ggplot(data = test1, mapping = aes(x=Time, y=weight, color=Chick))+
  geom_line()+
  geom_point()+
  theme_classic()+ # theme_gray() by default
  scale_color_manual(values = c("red","darkblue"))+ # set group color
  labs(title = "line chart", 
       #subtitle = "XXXXXXX", 
       #x = "XXXXX", y = "XXXXX"
       )+
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = unique(test1$Time))

# 2.Time series data------------------------------------------------------------
# 2.1 one variable--------------------------------------------------------------
df <- data.frame(date = seq(as.Date("2021-01-01"), as.Date("2021-12-31"), by = "month"),
                 value = rnorm(12))
df$date <- as.Date(df$date)

test2 <- df
ggplot(data = test2, mapping = aes(x=date, y=value))+
  geom_line()+
  geom_point()+
  theme_classic()+ # theme_gray() by default
  labs(title = "line chart", 
       #subtitle = "XXXXXXX", 
       #x = "XXXXX", y = "XXXXX"
  )+
  theme(plot.title = element_text(hjust = 0.5))

# 2.2 two variable--------------------------------------------------------------
df1 <- data.frame(date = seq(as.Date("2021-01-01"), as.Date("2021-12-31"), by = "month"),
                 value = rnorm(12))
df1$date <- as.Date(df1$date)

test3 <- rbind(df, df1)
test3$vari <- c(rep(1,12), rep(2,12)) %>% as.factor()
ggplot(data = test3, mapping = aes(x=date, y=value, color=vari))+
  geom_line()+
  geom_point()+
  theme_classic()+ # theme_gray() by default
  scale_color_manual(values = c("red","darkblue"))+ # set group color
  labs(title = "line chart", 
       #subtitle = "XXXXXXX", 
       #x = "XXXXX", y = "XXXXX"
  )+
  theme(plot.title = element_text(hjust = 0.5))+
  scale_x_continuous(breaks = unique(test3$date)) # show all
