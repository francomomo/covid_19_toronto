# Import library for data cleaning
library(janitor)
# Import library for data manipulation
library(tidyverse)
#
library(opendatatoronto)
#
library(dplyr)

# get package
package <- show_package("64b54586-6180-4485-83eb-81e8fae3b8fe")

# get all resources for this package
resources <- list_package_resources("64b54586-6180-4485-83eb-81e8fae3b8fe")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
raw_data <- filter(datastore_resources, row_number()==1) %>% get_resource()

covid_data <- raw_data %>%
  clean_names() 

# Write the cleaned data to a file
write_csv(covid_data, "./outputs/data/covid_data.csv")
