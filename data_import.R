#github test
# setup----
if (!require(tidyverse)) install.packages("tidyverse") else library(tidyverse)
library(ggplot2)
library(magrittr)

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
    Degree = as.factor(str_trim(gsub("\\(or equivalent)", "", Degree))),
    Playstyle = as.factor(ifelse(grepl("Singleplayer", Playstyle), "Singleplayer", "Multiplayer"))
    ) %>% 
  # remove na
  na.omit()

  
