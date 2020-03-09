
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

#Loads in the functions from the functions.R file. This functions file contains the timeplot method which is used
#When creating the timeline plot.
source('functions.R')

#Loads in the sheets from our excel workbook. in the format (filename, sheetNumber, skip=1 (skips the header in the sheet))
dashboard_sheet<-read_excel('ppm_data.xlsx',1, skip=1)
schedule_sheet<-read_excel('ppm_data.xlsx', 2, skip=1)
budget_sheet<-read_excel("ppm_data.xlsx",6, skip=1)

#Converts the schedule dates to the format DD/MM/YYYY 
#This is done to remove the timestamp that R converts the regular dates too since we do not need
#such precise date information. 
schedule_sheet$Planned.Start<-as.Date(as.character(schedule_sheet$Planned.Start))
schedule_sheet$Planned.End<-as.Date(as.character(schedule_sheet$Planned.End))
schedule_sheet$Actual.Start<-as.Date(as.character(schedule_sheet$Actual.Start))
schedule_sheet$Actual.End<-as.Date(as.character(schedule_sheet$Actual.End))

#Since project titles take up multiple rows, when it is important those extra rows have the project title "NA"
#to fix this, the method below replaces the NA with the previous value (the project name).
#to see what I mean, print the variavble before and after this method is called to see what it does.
schedule_sheet$Project<- na.locf(schedule_sheet$Project)
budget_sheet$Project <- na.locf(budget_sheet$Project)

#Filters the rows to only contain the rows with the "Total information" this is used for the budget graph
budget_sheet <- budget_sheet%>%
            filter(Type=="Total")   #Filter out all calculations except for the ones with the type "Total"
                                    #The current graphs only require the totals of project finances. This may change in the future
                                    #If this changes and individual Salary / O&M Values for each project are required, remove the filter.
                                    #This will require extra filtering inside of the methods in server.R that currently rely on the 
                                    #variable 'budget_sheet' only coming wit only totals. In other words, move the filtering of total 
                                    #into the methods that only require totals, instead of doing it here, right away.


#List of project names which is retrieved from the Project column inside the Dashboard sheet.
#This variable is used for the values inside of the drop down menu on the right of the dashboard. 
#Ie. This variable is pretty important.
#Note: This also means that all project names should be identical throughout each sheet inside the workboox otherwise the program
#will believe that no data exists for that certain project.
projects<-c('All',dashboard_sheet$`Project`)%>%
            sort() #Sorts all of the project title in alphabetical order. 
