#- - - - - - - - - - - - - - - - - - - -#
#                                       #
#    Prepare data to map earthworm      #
#      distribution in Europe           #
#        author: Romy Zeiss             #
#          date: 2022-08-16             #
#                                       #
#- - - - - - - - - - - - - - - - - - - -#

# load packages
library(tidyverse)

# load data
load("../data/SDM_stack_bestPrediction_binary_Crassiclitellata.RData") #species_stack
load("../data/SDM_stack_future_richness_change_Crassiclitellata.RData") #average_stack

head(average_stack)
head(species_stack)




richness_df <- average_stack

save(richness_df, file="Earthworms_in_Europe/richness_df.RData")
