## Step 1: First step is to load all needed packages
# ggplot2, readr, tidyr, dplyr, visdat, broom
library(ggplot2)
library(broom)
library(dplyr)
library(readr)
library(tidyr)
library(visdat)
library(diveMove)
vignette("diveMove")


##______________________________________________________________________________________________________________________##


## Step 2: Data cleaning
# Check the "class" or "data types" for each column
class(Blue.Fin.California.Dives.Data$animal.id)
class(Blue.Fin.California.Dives.Data$DiveDateStart)
class(Blue.Fin.California.Dives.Data$DiveDateEnd)
class(Blue.Fin.California.Dives.Data$LocationDate)
class(Blue.Fin.California.Dives.Data$TimeDifference)
class(Blue.Fin.California.Dives.Data$Lat)
class(Blue.Fin.California.Dives.Data$Lon)
class(Blue.Fin.California.Dives.Data$DiveDuration)
class(Blue.Fin.California.Dives.Data$MaxDiveDepth)
class(Blue.Fin.California.Dives.Data$NumLunges)
class(Blue.Fin.California.Dives.Data$BoutIndicator)

# Glimpse the data
glimpse(Blue.Fin.California.Dives.Data)

# Visualizing and dropping missing data
vis_miss(Blue.Fin.California.Dives.Data)


##_____________________________________________________________________________________________________________________##


## Step 3: Filtering for desired parameters
blue_05803 <- Blue.Fin.California.Dives.Data %>% filter(animal.id == "2014CA-Bmu-05803")
glimpse(blue_05803)


##_____________________________________________________________________________________________________________________##

sfp <- system.file("data", "C://Users//Peter Villarreal//Desktop//Data Analytics//Datasets//Austin's Future Data Scientists-Analysts/Blue-Fin Whales//blue_05803.csv", lib.loc = .libPaths()[1], package="diveMove", mustWork=TRUE)
[1] "C://Users//Peter Villarreal//Desktop//Data Analytics//Datasets//Austin's Future Data Scientists-Analysts/Blue-Fin Whales//blue_05803.csv"