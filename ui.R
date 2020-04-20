
#The ui.R file is responsible for the UI logic.
#The look of the whole page is configured in this file by configuring this dashboardPage function and placing it
#into the ui variable.

header <- dashboardHeader(title="TBI - PPM Dahsboard")

sidebar <- dashboardSidebar(
  sidebarMenu(id='sidebar',
              menuItem('Overview',tabName='overview'),
              conditionalPanel(
                condition="input.sidebar == 'overview' ",
                selectInput('selectproject',label="Select a Project",
                            choices=c('All',dashboard_sheet$Project))
              )),
  absolutePanel(
    bottom=15,left=50,style="opacity:0.8;",fixed=TRUE,draggable=FALSE,
    actionButton(inputId="update",label="Update data")
  )
)

body <- dashboardBody(
  
  tabItems(
    
    tabItem(tabName='overview',
            #Top row of the body where the project name is 
            fluidRow(
              div(style='display: inline-block;vertical-align:center;width:100%;', uiOutput('project_name')),
              div(style="display: inline-block;vertical-align:center; width: 300px;",HTML("<br>"))
            ),
            #Row containing the health and finance graphs
            fluidRow(
              box(title='Overall Project Health',plotOutput('project_health_plt'),height="505px"),
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
                  timevisOutput("schedule_plt"),
                  DT::dataTableOutput('schedule_tbl'))
            )
    )
  )
)

ui <- tagList(
  useShinyjs(),
  tags$head(
    tags$link(rel="stylesheet",type="text/css",href="style.css")
  ),
  
  # Main display ----------------------
  div(id="english",dashboardPage(skin="red",header,sidebar,body)),
      
  # Update screen --------------------
  div(
    id="form",
    style="display:none; background-color:#ecf0f6; margin:40px;",
    fluidRow(
      column(width=8,h2(style="margin-top:0;","Update PPM data")),
      column(width=4,style="text-align:right;",
             actionButton(inputId="exit",label="Exit"))
    ),
    fluidRow(
      style="margin:0 30px;",
      tags$table(
        tags$tr(
          tags$td(class="labelcol","Select project:"),
          tags$td(selectInput(inputId="project",label="",width="440px",
                              choices=c("- Create new project -",dashboard_sheet$Project)))
        )
      ),
      div(
        id="actiondiv",
        style="display:none;",
        tags$table(
          tags$tr(
            tags$td(class="labelcol","Action:"),
            tags$td(selectInput(inputId="actionsel",label="",
                                choices=c("Update project health","Update budget",
                                          "Update deliverables","Delete project")))
          )
        )
      ),
      div(
        id="health",
        style="display:none;",
        tags$table(
          tags$tr(
            tags$td(class="labelcol","Project health:"),
            tags$td(selectInput(inputId="healthsel",label="",
                                choices=c("On track","Attention required",
                                          "Immediate attention required","N/A")))
          ),
          tags$tr(tags$td(br())),
          tags$tr(
            tags$td(),
            tags$td(actionButton(inputId="update1",label="Update"))
          )
        )
      ),
      div(
        id="budget",
        style="display:none;",
        tags$table(
          tags$tr(
            tags$td(class="labelcol","Project budget:"),
            tags$td(numericInput(inputId="budgetinput",label="",value=0,min=0,
                                 step=0.01,width="100px")),
            tags$td("Actuals:"),
            tags$td(numericInput(inputId="actualsinput",label="",value=0,min=0,
                                 step=0.01,width="100px")),
            tags$td("Committed:"),
            tags$td(numericInput(inputId="committedinput",label="",value=0,min=0,
                                 step=0.01,width="100px")),
            tags$td("Anticipated:"),
            tags$td(numericInput(inputId="anticipatedinput",label="",value=0,min=0,
                                 step=0.01,width="100px"))
          ),
          tags$tr(tags$td(br())),
          tags$tr(
            tags$td(),
            tags$td(actionButton(inputId="update2",label="Update"))
          )
        )
      ),
      div(
        id="deliverable",
        style="display:none;",
        tags$table(
          tags$tr(
            tags$td(class="labelcol","Deliverable:"),
            tags$td(selectInput(inputId="delivsel",label="",width="440px",
                                choices=c("- Create new deliverable -"))),
            tags$td(style="padding-top:5px;",
                    actionButton(inputId="go2",label=" Select",icon=icon("sync-alt")))
          )
        )
      ),
      div(
        id="projdates1",
        style="display:none;",
        tags$table(
          tags$tr(
            tags$td(class="labelcol","New name:"),
            tags$td(textInput(inputId="delivname",label=""))
          )
        ),
        tags$table(
          tags$tr(
            tags$td(class="labelcol","Planned start:"),
            tags$td(dateInput(inputId="pstart1",label="",width="100px")),
            tags$td(style="text-align:right;","Planned end:"),
            tags$td(dateInput(inputId="pend1",label="",width="100px"))
          ),
          tags$tr(
            tags$td(class="labelcol","Actual start:"),
            tags$td(dateInput(inputId="astart1",label="",width="100px")),
            tags$td(style="text-align:right;","Actual end:"),
            tags$td(dateInput(inputId="aend1",label="",width="100px")),
            tags$td(class="labelcol","% complete"),
            tags$td(numericInput(inputId="percent1",label="",value=100,min=0,max=100,
                                 step=1,width="60px"))
          ),
          tags$tr(tags$td(br())),
          tags$tr(
            tags$td(),
            tags$td(actionButton(inputId="update3",label="Add"))
          )
        )
      ),
      div(
        id="projdates2",
        style="display:none;",
        tags$table(
          tags$tr(
            tags$td(class="labelcol","Planned start:"),
            tags$td(dateInput(inputId="pstart2",label="",width="100px")),
            tags$td(style="text-align:right;","Planned end:"),
            tags$td(dateInput(inputId="pend2",label="",width="100px"))
          ),
          tags$tr(
            tags$td(class="labelcol","Actual start:"),
            tags$td(dateInput(inputId="astart2",label="",width="100px")),
            tags$td(style="text-align:right;","Actual end:"),
            tags$td(dateInput(inputId="aend2",label="",width="100px")),
            tags$td(class="labelcol","% complete"),
            tags$td(numericInput(inputId="percent2",label="",value=0,min=0,max=100,
                                 step=1,width="60px"))
          ),
          tags$tr(tags$td(br())),
          tags$tr(
            tags$td(),
            tags$td(actionButton(inputId="update4",label="Update"))
          )
        )
      ),
      div(
        id="delete",
        style="display:none;",
        tags$table(
          tags$tr(
            style="height:35px;",
            tags$td(class="labelcol"),
            tags$td(em("Are you sure you want to delete this project?"))
          ),
          tags$tr(tags$td(br())),
          tags$tr(
            tags$td(),
            tags$td(actionButton(inputId="del",label="Delete"))
          )
        )
      ),
      div(
        id="new",
        style="display:none;",
        tags$table(
          tags$tr(
            tags$td(class="labelcol","Project name:"),
            tags$td(textInput(inputId="projname",label="")),
            tags$td("Project IP:"),
            tags$td(textInput(inputId="projip",label="",width="100px"))
          ),
          tags$tr(
            tags$td(class="labelcol","Project health:"),
            tags$td(
              selectInput(inputId="healthsel_new",label="",
                          choices=c("On track","Attention required",
                                    "Immediate attention required","N/A")))
          )
        ),
        tags$table(
          tags$tr(
            tags$td(class="labelcol","Project budget:"),
            tags$td(numericInput(inputId="budgetinput_new",label="",value=0,min=0,
                                 step=0.01,width="100px")),
            tags$td("Actuals:"),
            tags$td(numericInput(inputId="actualsinput_new",label="",value=0,min=0,
                                 step=0.01,width="100px")),
            tags$td("Committed:"),
            tags$td(numericInput(inputId="committedinput_new",label="",value=0,min=0,
                                 step=0.01,width="100px")),
            tags$td("Anticipated:"),
            tags$td(numericInput(inputId="anticipatedinput_new",label="",value=0,min=0,
                                 step=0.01,width="100px"))
          ),
          tags$tr(tags$td(br())),
          tags$tr(
            tags$td(),
            tags$td(colspan=2,
                    actionButton(inputId="update5",label="Create project")
            )
          )
        )
      ),
      div(id="successmsg",style="display:none;",br(),em("Project data updated.")),
      div(class="back")
    )
  )
)