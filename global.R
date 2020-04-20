
###############################Useful Shiny things#####################################
############# to deploy update use: rsconnect::deployApp("path/to/app") ###############
############# web link: https://hc-tbi.shinyapps.io/ppm_dashboard/      ###############
############# admin dashboard login: https://www.shinyapps.io/          ###############
#######################################################################################


#Global function is where are the global (accessible from other files) variables are located. This is where you do things
#like loading in the sheets from the ppm excel and include external libraries that may be needed throughout the application.

#Loads in the libraries needed
library(shiny)
library(shinyBS)
library(shinydashboard)
library(dplyr)
library(lubridate)
library(purrr)
library(tidyr)
library(data.table)
library(stringi)
library(plotly)
library(readxl)
library(scales)
library(DT)
library(zoo)
library(timevis)
library(shinyjs)

dashboard_sheet <- read.csv("health.csv",header=TRUE,na.strings=c(""))
schedule_sheet <- read.csv("progress.csv",header=TRUE,na.strings=c(""))
budget_sheet <- read.csv("budget.csv",header=TRUE,na.strings=c(""))

dashboard_sheet$Project <- as.character(dashboard_sheet$Project)
dashboard_sheet$IP <- as.character(dashboard_sheet$IP)
dashboard_sheet$Status <- as.character(dashboard_sheet$Status)

schedule_sheet$Project <- as.character(schedule_sheet$Project)
schedule_sheet$Deliverables <- as.character(schedule_sheet$Deliverables)
schedule_sheet$Planned.Start <- as.Date(schedule_sheet$Planned.Start,"%Y-%m-%d",tz="UTC")
schedule_sheet$Planned.End <- as.Date(schedule_sheet$Planned.End,"%Y-%m-%d",tz="UTC")
schedule_sheet$Actual.Start <- as.Date(schedule_sheet$Actual.Start,"%Y-%m-%d",tz="UTC")
schedule_sheet$Actual.End <- as.Date(schedule_sheet$Actual.End,"%Y-%m-%d",tz="UTC")

budget_sheet$Project <- as.character(budget_sheet$Project)
budget_sheet$Type <- as.character(budget_sheet$Type)
for(col in c("Budget","Actuals","Commitment","Anticipated","Total.Forecast")) {
  budget_sheet[is.na(budget_sheet[,col]),col] <- 0
}
