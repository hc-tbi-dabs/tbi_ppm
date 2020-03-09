
#The ui.R file is responsible for the UI logic.
#The look of the whole page is configured in this file by configuring this dashboardPage function and placing it
#into the ui variable. 
ui<-dashboardPage(skin="red",  
  #Sets the title @ the top left of the page and is also the name of the tab bar title in the browser 
  dashboardHeader(title="TBI's PPM Dahsboard",
                  titleWidth=400),
  #Creates a sidebar 
  dashboardSidebar(width=215,
                    #Creates 'Overview' sidebar menu,
                    sidebarMenu(id='sidebar',
                      menuItem('Overview',tabName='overview'),
                      #Creates panel with a drop down menu of project names. when  selected, graphs are updated.
                      conditionalPanel(
                        condition="input.sidebar == 'overview' ",
                        selectInput('selectproject',label="Select a Project",choices=projects)
                      ),
                     
                      #Contact button is added to the page. The variale 'contact' can and is used subscribing to te
                      #event input$contact inside of the serever.R function
                      actionButton('contact','Contact us',icon=icon('phone')))
  ),
  #Creates the boy of the dashboard
  dashboardBody(
    
    tabItems(
      
      tabItem(tabName='overview',
        #Top row of the body where the project name is 
        fluidRow(
                div(style='display: inline-block;vertical-align:center;width:100%;', uiOutput('project_name')),
                div(style="display: inline-block;vertical-align:center; width: 300px;",HTML("<br>"))
        ),
        #Row containing the health and finance graphs
        fluidRow(
          box(title='Overall Project Health',plotOutput('project_health_plt')),
          box(title='Project Finances',
                    #creates a tab inside the finance box that allows one to look at the Forecast Vs. Variance or 
                    #switch to looking at the graph displaying the Forecast vs. Actual
                    tabsetPanel(
                      tabPanel(title="Forecast vs. Variance",
                      plotOutput("budget_plt")),
                      tabPanel(title="Forecast vs. Actual", 
                      plotOutput("budget_actuals_plt"))
                    ))
          ),
        #Row containing the project timeline
        fluidRow(
            box(title='Project Timeline',width=12,
                    plotlyOutput('schedule_plt'),
                    br(),
                    br(),
                    br(),
                    br(),
                    DT::dataTableOutput('schedule_tbl'))
        )
              
      )
      
    )
            
  )             
)