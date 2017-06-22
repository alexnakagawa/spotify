# ====================================================

# An attempt to predict with a certain probability that a song will reach the Global Top 200

# ====================================================

# Libraries
library(neuralnet)
library(dplyr)
library(ggplot2)

# A little more Data Wrangling...
View(tracks.df)
View(features.df)
summary(features.df)
tracks.df = left_join(tracks.df, features.df, by = c('track.id'='id'))
class(tracks.df$track.id)
