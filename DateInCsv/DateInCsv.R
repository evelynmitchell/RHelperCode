#
# http://stackoverflow.com/questions/13022299/specify-date-format-for-colclasses-argument-in-read-table-read-csv
setClass("myDate")
setAs("character","myDate", function(from) as.Date(from, format="%m/%d/%Y") )
dat <- read.csv("file.csv", colClasses = c('numeric', 'myDate'))
