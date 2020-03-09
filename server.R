

# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
# In a nutshell, the server logic is where all of the creation of the graphs and filter of data occurs. 
# thingsl ike output$variable_name are connected to parts of the UI with the same variable. This is how the application
# is able to be reactive. 
#
#You can read more about it here: https://shiny.rstudio.com/tutorial/written-tutorial/lesson4/

#a shiny method that contains information about the session. all of your server logic will go inside this function
shinyServer(function(input, output,session) {
  
  #Method called when someone clicks on the contact us button.
  #This happens because we specify input$contact in the observeEvent method which tells it to 
  #observe the input$contact event which is attached to the actionbutton in the ui.R file.
  observeEvent(input$contact,{
    
    #pops up a modal with some simple html that could possibly contain contact information or something else.
    showModal (modalDialog(
      #sets the title of the modal dialog
      title='Contact Us',
      HTML(paste("Contact info can go here"
      )),
      easyClose=T #sets easy close to true, this makes it so if u click outside of the dialog, it will close.
    ))
  })
  
  #Method called when someone select a new project in the drop down menu. This method updates the title 
  #at the top of the page that says "Project:insertProjectName" in big font. 
  output$project_name<-renderUI({
    project_name<-paste0('Project:',input$selectproject) #sets the project name to be "Project:inserProjectName". The paste/paste0 method concatenates strings
    #creates a HTML headeding with the project name and uses some CSS to style it.
    h1(project_name, 
       style = "font-family: 'Arial';margin-left:17px;
        font-weight: 500; line-height: 1.1; 
        color: #2E4053;")
  })
  
  #Method called when someone selects a new project in the drop down menu. It returns the project name which is used throughout 
  #the server logic to determine which project(s) are currently selected /which ones should and shouldn't be filtered.
  project_selected<-reactive({
    
      if(input$selectproject=='All'){
        project_names<-dashboard_sheet$Project
      }else{
        project_names<-dashboard_sheet$Project[dashboard_sheet$Project==input$selectproject]
      }
      
    return(list(project_names=project_names))
  })

  #Method called when someone selects a new project in the drop down menu. This method creates the schedule time plot graph
  #that displays the difference between a project deliverable's Planned End and Actual End date. Note: If a project deliverable
  #does not have both a Planned End and Actual End date, it will not be ploted on the timeline. 
  output$schedule_plt<-renderPlotly({
   
    schedule_df <- filter(schedule_sheet,Project==project_selected()$project_names)

    #If there is not an actual end date, a message saying there is not enough info is displayed
    shiny::validate((
      need(any(!is.na(schedule_df$Actual.End)),'There is no information on project schedule')
    ))

    #If there is not an actual end date, a message saying there is not enough info is displayed
    shiny::validate((
      need(any(!is.na(schedule_df$Planned.End)),'There is no information on project schedule')
    ))
    
    #Creates the timeplot using with certain aesthetics. Most of the creation of the timplot is done in the timeplot() function located
    #inside of functions.R
    ggplotly(timeplot(schedule_df),height=450,tooltip=NULL)%>% #careates the splot w/ a specfic height, sets HTML tooltip to null
            layout(legend=list(orientation='h', #sets the looks of the legend
                               y=-10,
                               x=0.2))
  })
  
  #Method called when someone selects a new project in the drop down menu. This method creates the data table that is right underneath
  #the timeplot. This table should the planned end and actual end of the actual project. This is down by taking the 
  #oldest planned and actual end date. This is assumed to be equivalent to the project's end dates. These dates are then displayed

  output$schedule_tbl<-DT::renderDataTable({
    schedule_df <- schedule_sheet %>%
            filter(Project==project_selected()$project_names)%>% #Filters out the unselected project 
            group_by("Project" = Project)%>% #groups the data by project name
            summarise(
                      "Planned End" = max(na.omit(Planned.End)), #gets the max value of planned end, ignoring empty values unless it's the only option
                      "Actual End" = max(na.omit(Actual.End)))#gets the max value of actual end, ignoring empty values unless it's the only option 
   
    DT::datatable(schedule_df,options = list(dom = 'tip'), rownames = FALSE) #Creates the table using the data frame 
  })

  #Creates the overall project health graph

  #Method called when someone selects a new project in the drop down menu. This method creates the bar graph of the project's 
  #overall health. This info is inside the Dashboard sheet in 2 columsn 'Overall Project Health' and 'Status'
  output$project_health_plt<-renderPlot({
    #Creates a list matching each status with a specific bar colour. Eg On Track = green.
    cols<-c('On Track'='#03B150','Attention Required'='#FFC000','Immediate Attention Required'='#C01900')
    health_df<-dashboard_sheet%>%filter(Project==project_selected()$project_names)%>% #filters out the unselected projects
      filter(`Overall Project Health`!='N/A')%>% #filters out the empty overall project helath cells. 
      group_by(Status)%>% #Groups the data by each project's status
      summarise(ProjectName=paste(Project,collapse='\n\n'),count=n()) #selects the project column and joins all the project names together and keeps track of the number projects in each group

    #Plots the bar graph 
    p<-ggplot(health_df,aes(x=Status,y=count,fill=Status))+geom_col()+
      scale_fill_manual(values=cols)+ #sets the bar colours to use the 'cols' list specified above
      scale_y_continuous(breaks=c(0,1,2,3,4,5,6,7,8,9,10,11,12))+ #sets the Y intervals 
      geom_text(aes(y=count,label=ProjectName),vjust=1.2, size=2.80)+ #lets the y value to be the count
      geom_text(aes(label=as.character(count)),vjust=-0.5)+ #sets the text to do display the count just above the bar's height
      guides(fill=F)+ #hides the legend 
      theme_minimal()+ #uses a pre defined minimal theme that makes the background white
      theme(axis.title.x=element_blank(), #sets the x axis title to blank 
            axis.text.x =element_text(size=12), #sets the x axis text to have a font size of 12
            axis.title.y =element_blank(),  #sets the y axis title to blank
            legend.title=element_blank() #sets the legend title to blank
      )
    p
  })
  #Method called when someone selects a new project in the drop down menu. This method creates a budget graph that will display the 
  #Actusl vs. the Forecast value. It does this by using the 'Budget' sheet and manipulating the data.
  output$budget_actuals_plt <- renderPlot({
    df <- budget_sheet
      #Checks if the selected field is all projects.
      #If it is, the totals of actuals and forecast are calculated and a new data is created
      #An example of how this data might look is this:
      #
      # Project         Actuals           Total Forecast
      # Gadget          $ 20               $25
      #
      #This data is then "melted". this is what is needed to create a double bar graph. Melting the data results in every column
      #excep the one specific in the id.vars parameter to be turned into it's own row. For example, the table above would
      #appear like this after being melted:
      #
      #Project  Values
      #Gadget   $20
      #Gadget   $25
      if(input$selectproject=='All'){
        Project <- "All"
        Actuals <- sum(budget_sheet$Actuals)
        Forecast <- sum(budget_sheet$"Total Forecast")
        budget_df <- melt(data.frame(Project,Forecast, Actuals), id.vars="Project")
      
      }
      else{
        #If the user has selected a specific project in the drop down menu, then the data is filtered to 
        #get the data of the specific project. Only the 3 columns that are relevant are selected
        #project, total forecast and actuals. That data is then melted the same way that the data is melted 
        #when the user selects all projects.
        df <- budget_sheet %>%
            filter(Project==project_selected()$project_names) 
        budget_df <- melt(df[,c("Project","Total Forecast", "Actuals")], id.vars="Project")
      }

      #plots the bar grap 
      p <- ggplot(budget_df,  aes(x=input$selectproject, y=value)) + geom_bar(aes(fill = variable), #Adds the bars to the graph
      width = 0.4, position = position_dodge(width=0.5), stat="identity") + #sets with and position of bars
      theme_minimal() + #uses a pre defined minimal theme that makes the background white
      scale_fill_manual(values=c("#9fd3c7", "#385170")) + #sets the colours of the 2 bars in the group 
      theme(legend.position="top", #sets the legend postion to be @ the top 
            legend.title = element_blank(), #sets the legend's title to be empty 
            axis.title.x=element_blank(), #sets the x axis title to be empty
            axis.title.y=element_blank()) #sets the y title to be empty
      p
  })


  #Creates the Budget Graph based on the total forecast and variance  
  #Method called when someone selects an new project in the drop down menu. This method creates the double bar graph
  #that compares the Variances to the Forecast. this method is pretty much identical to the method budget_plt_actuals method
  #expect for the fact that actuals is now placed with variance. The logic is the same.
  output$budget_plt<-renderPlot({
      df <- budget_sheet
       #Checks if the selected field is all projects.
      #If it is, the totals of variance and forecast are calculated and a new data is created
      #An example of how this data might look is this:
      #
      # Project         Variance           Total Forecast
      # Gadget          $ 20               $25
      #
      #This data is then "melted". this is what is needed to create a double bar graph. Melting the data results in every column
      #excep the one specific in the id.vars parameter to be turned into it's own row. For example, the table above would
      #appear like this after being melted:
      #
      #Project  Values
      #Gadget   $20
      #Gadget   $25
      if(input$selectproject=='All'){
        Project <- "All"
        Variance <- sum(budget_sheet$Variance)
        Forecast <- sum(budget_sheet$"Total Forecast")
        budget_df <- melt(data.frame(Project,Forecast, Variance), id.vars="Project") 
      
      }
      else{
        #If the user has selected a specific project in the drop down menu, then the data is filtered to 
        #get the data of the specific project. Only the 3 columns that are relevant are selected
        #project, total variance and actuals. That data is then melted the same way that the data is melted 
        #when the user selects all projects.
        df <- budget_sheet %>%
            filter(Project==project_selected()$project_names) 
        budget_df <- melt(df[,c("Project","Total Forecast", "Variance")], id.vars="Project")
      }
    
      p <- ggplot(budget_df,  aes(x=input$selectproject, y=value)) + geom_bar(aes(fill = variable), # #Adds the bars to the graph
      width = 0.4, position = position_dodge(width=0.5), stat="identity") + #sets width and position of bars
      theme_minimal() + #uses a predefined minimal theme to that places replaced the default grey bg of the graph with white.
      theme(legend.position="top", #sets the legend position to be at the top 
            legend.title = element_blank(), #sets the legend title to blank
            axis.title.x=element_blank(), #sets the x axis title to blank
            axis.title.y=element_blank()) #sets the y axis title to blank
      p
    })
})
