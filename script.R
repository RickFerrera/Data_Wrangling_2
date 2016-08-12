##Part 0: Load as data frame
titanic_original <- read.csv("~/Springboard/Data_Wrangling_2/titanic_original.csv", header=TRUE, na.strings=c("","NA"))
library(dplyr)
titanic_original <- tbl_df(titanic_original)
View(titanic_original)

##Part 1: Replace missing values in embarked column with Southampton
titanic_original %>%
  group_by(embarked) %>%
  summarise(Count = n_distinct(name))

###This tells me there are only two missing values - now let's fix that
titanic_original$embarked[is.na(titanic_original$embarked)] <- "S"

###Test again
titanic_original %>%
  group_by(embarked) %>%
  summarise(Count = n_distinct(name)) ### It worked

##Part 2: Replace missing age values with mean of ages
mean_age <- mean(titanic_original$age, na.rm = TRUE) 
titanic_original$age[is.na(titanic_original$age)] <- mean_age
###Check that it worked
mean <- titanic_original %>%
  group_by(age) %>%
  summarise(Count = n_distinct(name))
View(mean) ### It did


## Part 3: Fill in missing values in boat with NA
### Check the data 
boats_check <- titanic_original %>%
  group_by(boat) %>%
  summarise(Count = n_distinct(name))  
View(boats_check) ### Looks like there are 800+ NAs - so we already accomplished this step 
### by way of importing it well with the na.strings=c("","NA")



## Part 4: Create has_cabin_number variable
titanic_original["has_cabin_number"] <- 0
titanic_original$has_cabin_number <- ifelse(is.na(titanic_original$cabin),0,1)


##Save cleaned data
write.table(titanic_original, file = "titanic_clean.csv", append = FALSE, quote = TRUE, sep = " ",
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")


