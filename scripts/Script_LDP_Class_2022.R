library(rdryad)

#create directories
dir.create("data/")
dir.create("scripts/")
dir.create("output/")
dir.create("manuscript/")

dir.create("data/url/")
dir.create("data/dryad/")
dir.create("data/github/")

#starting to use groundhog by downlading commonly used R packages 
install.packages("groundhog")
library(groundhog)
groundhog.library(dplyr, date = "2022-08-31")
groundhog.library("tidyverse", date = "2022-08-31")
groundhog.library("ggplot2", date = "2022-08-31")

#Downloaded turkey lake watershed invertebrate density data
invert.density.url <- "https://ftp.maps.canada.ca/pub//nrcan_rncan/Forests_Foret/TLW/TLW_invertebrateDensity.csv"
invert.density.destfile <- "/Users/toryh/OneDrive/Documents/School Work/Classes/Productivity+Reproduibility/Project/LDP_Class_project/data/url/NRCAN_invert_density.csv"

# Downloaded associated metadata

invert.metadata.url <- "https://ftp.maps.canada.ca/pub//nrcan_rncan/Forests_Foret/TLW/TLW_invertebrate_metaEN.csv"
invert.metadata.destfile <- "/Users/toryh/OneDrive/Documents/School Work/Classes/Productivity+Reproduibility/Project/LDP_Class_project/data/url/NRCAN_invert_metadata.csv"
download.file(invert.metadata.url, invert.metadata.destfile, method = "curl", extra = "-k")

dat <- read.csv("/Users/toryh/OneDrive/Documents/School Work/Classes/Productivity+Reproduibility/Project/LDP_Class_project/data/url/NRCAN_invert_density.csv")

##table showing catchment categories
table(dat$catchment)

## Creating a new column to isolate catchments 31, 33, and 34, which are the ones that experienced forest harvest
dat <- dat %>% mutate(harvest = if_else(catchment == "33" | catchment == "34L" | catchment == "34M" | 
                                          catchment == "34U", true = "yes", false = "no"))
table(dat$harvest)
#result is 521 yes

# because this is a practice assignment I picked on genus: Chelifera
chelifera <- dat %>% select(catchment, year, month, replicate, chelifera, harvest)

## date format to plot as a time series
table(chelifera.sum$month)
chelifera.sum <- chelifera.sum %>% mutate(month2 = if_else(month == "june", "06", if_else(month == "may", "05", 
                                                                                    if_else(month == "november", "11", if_else(month =="october", "10",
                                                                                                                               if_else(month == "september", "09", "0"))))))
# combine month and year
chelifera.sum <- chelifera.sum %>% unite(col = "year.month", year, month2, sep = "-")

## adding a day to get into yyyy-mm-dd format that R likes, the data file does not specify the day, so we're just going to use the first of the month
chelifera.sum <- chelifera.sum %>% mutate(ymd = as.Date(paste(year.month,"-01",sep="")))

#looking at formatting 
str(chelifera.sum$ymd)


# check out distribution
hist(chelifera.sum$mean.dens)
hist(log10(chelifera.sum$mean.dens))

p <- ggplot(chelifera.sum, aes(x=ymd, y=mean.dens, color = harvest)) +
  geom_line() + 
  xlab("Year")+
  ylab("Mean density (# per sq. m)")+
  scale_y_log10()+
  theme_cowplot()

p







#github
##practicing downloading data from github

dir.create("/Users/toryh/OneDrive/Documents/School Work/Classes/Productivity+Reproduibility/Project/div")
usethis::create_from_github(repo_spec = "https://github.com/kguidonimartins/betadiv-enp",
                            destdir = "/Users/toryh/OneDrive/Documents/School Work/Classes/Productivity+Reproduibility/Project/div")
                                        
#creating a copy of the data file from github to personal data file
system("cp -r~/School Work/Classes/Productivity+Reproduibility/Project/div/betadiv-enp* data/github/.")


#running tinytex
install.packages("tinytex")
tinytex::install_tinytext()