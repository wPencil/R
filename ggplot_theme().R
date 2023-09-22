library(ggplot2)

# 1.theme_gray() by dafault-----------------------------------------------------
ggplot(mtcars, aes(x=mpg, y=cyl))+
  geom_point()
ggsave("theme_gray().png", dpi = 500)

# 2.theme_bw()------------------------------------------------------------------
ggplot(mtcars, aes(x=mpg, y=cyl))+
  geom_point()+
  theme_bw()
ggsave("theme_bw().png", dpi = 500)

# 3.theme_classic()-------------------------------------------------------------
ggplot(mtcars, aes(x=mpg, y=cyl))+
  geom_point()+
  theme_classic()
ggsave("theme_classic().png", dpi = 500)

# 4. theme_dark()---------------------------------------------------------------
ggplot(mtcars, aes(x=mpg, y=cyl))+
  geom_point()+
  theme_dark()
ggsave("theme_dark().png", dpi = 500)

# 5. theme_light()--------------------------------------------------------------
ggplot(mtcars, aes(x=mpg, y=cyl))+
  geom_point()+
  theme_light()
ggsave("theme_light().png", dpi = 500)

# 6. theme_linedraw()-----------------------------------------------------------
ggplot(mtcars, aes(x=mpg, y=cyl))+
  geom_point()+
  theme_linedraw()
ggsave("theme_linedraw().png", dpi = 500)

# 7. theme_minimal()------------------------------------------------------------
ggplot(mtcars, aes(x=mpg, y=cyl))+
  geom_point()+
  theme_minimal()
ggsave("theme_minimal().png", dpi = 500)

# 8. theme_void()---------------------------------------------------------------
ggplot(mtcars, aes(x=mpg, y=cyl))+
  geom_point()+
  theme_void()
ggsave("theme_void().png", dpi = 500)

# Set theme globally
theme_set(theme_classic())

# my plot-----------------------------------------------------------------------
ggplot(mtcars, aes(x=mpg, y=cyl))+
  geom_point()+
  theme_bw()+
  theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank())
ggsave("my_plot.png", dpi = 500)
