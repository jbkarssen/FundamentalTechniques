#github test
# setup----
if (!require(tidyverse)) install.packages("tidyverse") else library(tidyverse)
library(ggplot2)

# The file which is loaded below still includes all variables.
# Game titles are normalized, top 10 games ranked, rest grouped as "Other".
# 
# VARIABLES OF INTEREST
# VARIABLE[S]   TYPE      EXPLANATION
# Hours         num       Hours played
# streams       num       Additionnal hours dealing with the Game except playing
# Game          char      Which Game did the play the most?

# SPIN_T        num       total SPIN score
# SPIN_T[1-17]  num       individual SPIN item scores
# GAD_T         num       total GAD score 
# GAD[1-7]      num       individual GAD item scores
# SWL_T         num       total SWL score 
# SWL[1-5]      num       individual SWL item scores
# Narcissism    num       Score of the 1-item Narcissism scale
# 
# Birthplace    char      Country of Birth
# Residence     char      Country of Residence
# Age           num       Age
# Work          char      Occupation status (forced choice, no free-text field)
# Degree        char      Highest degree (forced choice, no free-text field)
# Gender        char      Gender

# import ----

# actual import call 
clean_data = "GamingStudy_data.csv" %>% 
  read.csv2(sep = ",", header = T, ) %>% 
  # to tibble
  as_tibble %>% 
  # select columns for research
  dplyr::select(SWL_T, SPIN_T, Age, Hours, Degree, Game, Playstyle) %>% 
  # clean up variables (remove text and extract singleplayer/multiplayer) & to factors (categorical)
  mutate(
    Game = as.factor(Game),
    Degree = as.factor(trimws(gsub("\\(or equivalent)", "", Degree))),
    Playstyle = as.factor(ifelse(grepl("Singleplayer", Playstyle), "Singleplayer", "Multiplayer"))
    ) %>% 
  # remove na
  na.omit()

# detecting and removing outliers
#SWL_T
barplot_SWL_T <- ggplot(clean_data, aes(x = SWL_T)) + 
  geom_bar(stat = "count")
summary(clean_data$SWL_T)
#SPIN_T
barplot_SPIN_T <- ggplot(clean_data, aes(x = SPIN_T)) +
  geom_bar(stat = "count") 
summary(clean_data$SPIN_T)
#AGE
barplot_Age <- ggplot(clean_data, aes(x = Age)) + 
  geom_bar(stat = "count")
summary(clean_data$Age)

#Hours
clean_data <- clean_data[clean_data$Hours < 126,]
summary(clean_data$Hours)
barplot_Hours <- ggplot(clean_data, aes(x = Hours)) + 
  geom_bar()

#Degree 
summary(clean_data$Degree)
barplot_Degree <- ggplot(clean_data, aes(x = Degree)) + 
  geom_bar(stat = "count")

#Game 
summary(clean_data$Game)
barplot_Game <- ggplot(clean_data, aes(x = Game)) + 
  geom_bar(stat = "count")

#Playstyle
summary(clean_data$Playstyle)
barplot_Playstyle <- ggplot(clean_data, aes(x = Playstyle)) + 
  geom_bar(stat = "count")
