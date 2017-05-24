################################################################
#### Name: 3_create_unique_RData.R
#### Description: script which imports different cleaned Sky Go datasets, bind them and save them into a unique RData
#### Author: Enrico Tonini
#### Co-authors: 
#### Start date: 2017-03-08
### End date: 
################################################################

 
################################################################
#### 0. PRELIMINARY OPERATIONS

### Remove all objects in the environment
rm(list = ls())

### Set working directory
# setwd("analytics/")

### Parameters
lib_version <- "20170420"

# channel_name <- "Sky_Uno"
# channel_name <- "Sky_Sport1"
channel_name <- "all_channels"

event_name <- "SSTT"
# event_name <- "SE"

day <- "20170402"
# day <- "20170312"

period <- "20170402_1430-1729"
# period <- "20170307_2030-2329"


### Import library
name_lib_script <- paste0("code/lib_", lib_version, ".R")
source(file = name_lib_script)


################################################################
#### 1. IMPORT TEXT FILES AND EXPORT INTO RDATA 

### Data

## Dir paths
input_data_path <- file.path("data/output", channel_name, event_name, day, "single_periods")
input_data_fn <- list.files(path = input_data_path, pattern = ".RData$", full.names = FALSE)
input_data_fn_fp <- list.files(path = input_data_path, pattern = ".RData$", full.names = TRUE)
output_data_path <- file.path("data/output", channel_name, event_name, day)
output_data_RData_fn <- period %+% "_" %+% channel_name %+% "_" %+% event_name %+% "_cleaned.RData"
output_data_RData_fn_fp <- file.path(output_data_path, output_data_RData_fn)

## Loading
df <- input_data_fn_fp %>% lapply(FUN = function(x){
  load(x)
  print(dim(df))
  return(df)
}) %>% bind_rows

## Save df
save(df, file = output_data_RData_fn_fp, compress = TRUE)

