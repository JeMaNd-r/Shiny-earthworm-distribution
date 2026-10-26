#- - - - - - - - - - - - - - - - - - - -#
#                                       #
#    Prepare data to map earthworm      #
#      distribution in Europe           #
#        author: Romy Zeiss             #
#          date: 2026-10-26             #
#                                       #
#- - - - - - - - - - - - - - - - - - - -#

# set working directory to source file location
getwd()

# load packages
library(tidyverse)

# load data
load("data/SDM_stack_bestPrediction_binary_Crassiclitellata.RData") # species_stack
load("data/SDM_stack_future_richness_change_Crassiclitellata.RData") # average_stack
load("data/SDM_stack_future_species_Crassiclitellata.RData") # future_stack
load("data/SDM_Uncertainty_Crassiclitellata.RData") # uncertain_df

head(average_stack)
head(species_stack)
head(future_stack)
head(uncertain_df)

# richness df
richness_df <- average_stack

save(richness_df, file = "data/richness_df.RData")

# species df
species_df <- full_join(species_stack, future_stack)
head(species_df)

save(species_df, file = "data/species_df.RData")

# uncertainty df
save(uncertain_df, file = "data/uncertain_df.RData")
