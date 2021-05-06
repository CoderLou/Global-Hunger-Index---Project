packs <- c("googleVis", "tidyr", "gridExtra", "dplyr", "plyr", "stringr", "data.table", "ggplot2", "scales", "plotly", "gganimate")
for ( p in packs) library(p, character.only = T)
rm(packs, p)



#Bring in Global Hunger Index Calculations Dataset
ghi <- read.csv("https://raw.githubusercontent.com/CoderLou/Global-Hunger-Index---Project/main/Datasets/002_AppendixC_GHIscores.csv")

#Drop Extra Columns
ghi<- ghi[-c(7:15)]

#Drop Extra Rows
ghi <- ghi[-c(1:3,11,15,22,30:31,42, 71, 96,100,109,111,113,116),]

#Rename Columns
ghi<- ghi %>%
  rename(
    "Country" = "X2015.Global.Hunger.Index.Scores",
    "1990" = "X",
    "1995" = "X.1",
    "2000" = "X.2",
    "2005" = "X.3",
    "2015" = "X.4"
  )
#Re-coding Missing Values to Zero
ghi[ghi == "?"] <- 0
#Re-coding character value to mean numeric
ghi[ghi == "<5"] <- (0+5)/2



#Column Conversion to Numeric
ghi[, c(2:6)] <- sapply(ghi[, c(2:6)], as.numeric)
 

#### Box Plots of Summary Statistics ####
box <- plot_ly(ghi, y = ~`1990`, type = "box", name = "1990", height=630, width=880)
box <- box %>% add_trace(y = ~`1995`, type = "box", name = "1995")
box <- box %>% add_trace(y = ~`2000`, type = "box", name = "2000")
box <- box %>% add_trace(y = ~`2005`, type = "box", name = "2005")
box <- box %>% add_trace(y = ~`2015`, type = "box", name = "2015")
box <- box %>% layout(title = "Summary Statistics of GHI Scores by Year")

box
##############################################################################

#Bring in Datasets about progress on world hunger solutions
#Food Insecurity Data
sec <- read.csv("https://raw.githubusercontent.com/CoderLou/Global-Hunger-Index---Project/main/Datasets/share-of-population-with-moderate-or-severe-food-insecurity.csv")

#Rename Column 
sec <- sec %>% 
  rename("Percent" = "Suite.of.Food.Security.Indicators...Prevalence.of.moderate.or.severe.food.insecurity.in.the.total.population..percent...3.year.average....210091...Value...6121...."
         )


#### Scatter Plot - Food Insecurity ####

scat1 <- plot_ly(data = sec, x = ~Year, y = ~Percent, color = ~Year, size = ~Percent, type = "scatter", mode = "markers")
scat1 <- scat1 %>% layout(title = "Percentages of Food Insecurity by Year (2015-2017)")

scat1


#Undernourishment Data
und <- read.csv("https://raw.githubusercontent.com/CoderLou/Global-Hunger-Index---Project/main/Datasets/prevalence-of-undernourishment.csv")

#Rename Column
und <- und %>%
  rename("Percent" = "Suite.of.Food.Security.Indicators...Prevalence.of.undernourishment..percent...3.year.average....210041...Value...6121...."
         )
#### Scatter Plot - Undernourishment ####

scat2 <- plot_ly(data = und, x = ~Year, y = ~Percent, color = ~Year, size = ~Percent,type = "scatter", mode = "markers", width = 1000)
scat2 <- scat2 %>% layout(title = "Percentages of Undernourished Populations by Year (2000-2017)")

scat2
