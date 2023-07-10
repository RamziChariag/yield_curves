library(dplyr)
library(tidyr)

# Path to the folder containing the chunked data
data_folder <- "data/"

# Load data
AAA_yield_curve_data <- read.csv(paste0(data_folder, "AAA.csv"))
euroarea_yield_curve_data <- read.csv(paste0(data_folder, "euroarea.csv"))

# Get only beta and tau by filtering
filtered_AAA <- filter(AAA_yield_curve_data, 
                       DATA_TYPE_FM %in% c('BETA0', 'BETA1', 'BETA2',
                                           'BETA3', 'TAU1', 'TAU2'))

filtered_euroarea <- filter(euroarea_yield_curve_data, 
                       DATA_TYPE_FM %in% c('BETA0', 'BETA1', 'BETA2',
                                           'BETA3', 'TAU1', 'TAU2'))


# Select the desired columns and pivot
AAA_parameters <- filtered_AAA %>% select(TIME_PERIOD, DATA_TYPE_FM, OBS_VALUE)
euroarea_parameters <- filtered_euroarea %>% select(TIME_PERIOD, DATA_TYPE_FM, OBS_VALUE)

pivoted_AAA <- AAA_parameters %>% pivot_wider(names_from = DATA_TYPE_FM, values_from = OBS_VALUE)
pivoted_euroarea <- euroarea_parameters %>% pivot_wider(names_from = DATA_TYPE_FM, values_from = OBS_VALUE)


# Save data frames as CSV file
write.csv(pivoted_AAA,paste0(data_folder, "AAA_parameters.csv"), row.names = FALSE)
write.csv(pivoted_euroarea,paste0(data_folder, "euroarea_parameters.csv"), row.names = FALSE)
                           
                           
                           
                           



  