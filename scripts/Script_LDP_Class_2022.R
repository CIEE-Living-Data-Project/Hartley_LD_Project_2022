library(rdryad)

#create directories
dir.create("data/")
dir.create("scripts/")
dir.create("output/")
dir.create("manuscript/")

dir.create("data/url/")
dir.create("data/dryad/")
dir.create("data/github/")

data.url <- "https://ftp.maps.canada.ca/pub//nrcan_rncan/Forests_Foret/TLW/TLW_invertebrateDensity.csv"
metadata.url <- "https://ftp.maps.canada.ca/pub//nrcan_rncan/Forests_Foret/TLW/TLW_invertebrate_metaEN.csv"


data.dest.file <- "C:/Users/toryh/OneDrive/Documents/School Work/Classes/Productivity+Reproduibility/Project/LDP_Class_project/data/url/NRCAN_invert_density.csv"
download.file(url= data.url, destfile = data.dest.file)

metadata.dest.file <- "C:/Users/toryh/OneDrive/Documents/School Work/Classes/Productivity+Reproduibility/Project/LDP_Class_project/data/url/NRCAN_invert_metadata.csv"
download.file(url= data.url, destfile = data.dest.file)


#github
##practicing downloading data from github

dir.create("/Users/toryh/OneDrive/Documents/School Work/Classes/Productivity+Reproduibility/Project/div")
usethis::create_from_github(repo_spec = "https://github.com/kguidonimartins/betadiv-enp",
                            destdir = "/Users/toryh/OneDrive/Documents/School Work/Classes/Productivity+Reproduibility/Project/div")
                                        
#creating a copy of the data file from github to personal data file
system("cp -r~/School Work/Classes/Productivity+Reproduibility/Project/div/betadiv-enp* data/github/.")

#starting to use groundhog
library(groundhog)

#running tinytex
install.packages("tinytex")
tinytex::install_tinytext()
