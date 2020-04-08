# Jan-Philipp Kolb
# Wed Jun 05 14:31:31 2019

library(magrittr)

###############################################
# functions

prep_picnames <- function(txt){
  ind <- agrep("![]",txt)
  pics <- txt[ind]
  pics2 <- strsplit(split = "\\(",x=pics)
  pics3 <- unlist(lapply(pics2,function(x)ifelse(length(x)==3,x[3],x[2]))) 
  pics3 <- gsub("filepath,\"","",pics3)
  pics3 <- gsub("\\)","",pics3)
  pics3 <- gsub("\")`)","",pics3)
  pics3 <- pics3 %>% strsplit(split = "\\{") %>% lapply(function(x)x[1]) %>% unlist()
  ind_https <- agrep("https",pics3)
  if (length(ind_https)!=0){
    pics3 <- pics3[-ind_https]  
  }
  return(pics3)
}

###############################################
# set paths

sysInfo <- Sys.info()

if (sysInfo["nodename"]=="MAC14026"){
  new.folder <- "D:/github/geows/slides/"
  path_wherepicslive <- "D:/github/summerschool_uganda/slides/"
}

if (sysInfo["nodename"]=="MAL15039"){
  new.folder <- "E:/github/geows/slides/"
  path_wherepicslive <- "E:/github/GeoData/2017/slides/"
  path_wherepicslive <- "E:/github/geocourse/slides/"
}

new.folder.fig <- paste0(new.folder,"/figure/")

#################################
# Für den R-Einführungsworkshop 2020

setwd(new.folder)

myfiles <- dir(new.folder) %>% grep(pattern = ".Rmd",value=T)


i <- length(myfiles)
myfile <- myfiles[i]
txt <- readLines(myfile)
pics3 <- prep_picnames(txt)


setwd(path_wherepicslive)
file.copy(pics3, new.folder.fig)


#################################
# Für meinen Gesis Workshop 2019

setwd(new.folder)

myfiles <- c("Import.Rmd","LineareRegression.Rmd","DatenVerarbeitung.Rmd","GESISPanel.Rmd")

i <- length(myfiles)
myfile <- myfiles[i]

txt <- readLines(myfile)

pics3 <- prep_picnames(txt)


setwd(path_wherepicslive)

file.copy(pics3, new.folder.fig)

###############################################





###############################################
# Links

# https://cran.r-project.org/web/packages/readtext/vignettes/readtext_vignette.html
# https://stackoverflow.com/questions/27721008/how-do-i-deal-with-special-characters-like-in-my-regex
# https://stackoverflow.com/questions/24173194/remove-parentheses-and-text-within-from-strings-in-r

###############################################
# code snippets

# install.packages("readtext")
library(readtext)


pics2 <- gsub("\\!\\[\\]\\(","",pics)
pics3 <- gsub("\\)","",pics2)


# gsub("\\s*\\([^\\)]+\\)","",pics)