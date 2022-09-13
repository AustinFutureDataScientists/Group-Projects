## Step 1: First step is to load all needed packages
# ggplot2, readr, tidyr, dplyr, visdat, corrplot, broom, ggmap
library(ggplot2)
library(broom)
library(corrplot)
library(dplyr)
library(ggmap)
library(readr)
library(tidyr)
library(visdat)


##______________________________________________________________________________________________________________________##


## Step 2: Data cleaning
# Check the "class" or "data types" for each column
class(housing$longitude)
class(housing$latitude)
class(housing$housing_median_age)
class(housing$total_rooms)
class(housing$total_bedrooms)
class(housing$population)
class(housing$households)
class(housing$median_income)
class(housing$median_house_value)
class(housing$ocean_proximity)

# Glimpse the data
glimpse(housing)

# Visualizing and dropping missing data
vis_miss(housing)
sum(is.na(housing))
no_na_df <- housing %>% filter(!is.na(total_bedrooms))
vis_miss(no_na_df)


##______________________________________________________________________________________________________________________##


## Step 3: Column Selection
# New dataframe will be called "eda_df"
# I am using this dataframe to build the correlation matrix and the regression analysis
eda_df <- no_na_df %>% select(housing_median_age, total_rooms, total_bedrooms, population, households, median_income, median_house_value)
head(eda_df)


##____________________________________________________________________________________________________________________##


## Step 4: Correlation Matrix
correlation_matrix <- cor(eda_df, use = "all.obs", method = "pearson")
correlation_matrix

corrplot(correlation_matrix, method = "color", main = "Correlation of All Numeric Values")

ggplot(eda_df, aes(x = households, y = total_bedrooms)) + geom_point() + geom_smooth(method = "lm", se = FALSE) + labs(title = "Total Bedrooms vs. Households in California")


##____________________________________________________________________________________________________________________##


## Step 5: Geospatial analysis of median house value and total bedrooms in California
# First, get the API key from google maps and register the key; notice is has been coded for R to do this automatically
# Second, acquire the map's coordinates calling the vector "myLocation"
# Third, create the vector "myMap" to display the map of California
# Fourth, overlay the individual data points onto the map, coloring by increasing median house value and total bedrooms
register_google(key = "AIzaSyDV_P1WgvkvgrCMAp16AdpLV3-oHILrPnI", write = TRUE)
myLocation <- c(-124.409591, 32.534156, -114.131211, 42.009518)
myMap <- get_map(location = myLocation, source ="stamen", maptype = "terrain", crop=FALSE, zoom = 9)
ggmap(myMap) + geom_point(aes(x = longitude, y = latitude, color = median_house_value, size = total_bedrooms), data = no_na_df, alpha = 0.5) + scale_color_gradient(low = "yellow", high = "red") + labs(title = "Total Bedrooms vs. Median House Values in California")