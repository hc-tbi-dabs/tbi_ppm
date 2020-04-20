

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

shinyServer(function(input, output,session) {
  
  runjs('document.getElementById("update").onclick = function() {
           $("#form").show();
           $("#english").hide();
           $("#successmsg").hide();
         };
         document.getElementById("exit").onclick = function() {
           $("#form").hide();
           $("#english").show();
           $("#successmsg").hide();
         };
         document.getElementById("actionsel").onchange = function() {
           $("#health").hide();
           $("#budget").hide();
           $("#deliverable").hide();
           $("#delete").hide();
         if($("#actionsel").val()=="Update project health") {
           $("#health").show();
         }
         if($("#actionsel").val()=="Update budget") {
           $("#budget").show();
         }
         if($("#actionsel").val()=="Update deliverables") {
           $("#deliverable").show();
         }
         if($("#actionsel").val()=="Delete project") {
           $("#delete").show();
         }
         $("#projdates1").hide();
         $("#projdates2").hide();
         $("#successmsg").hide();
         };
         document.getElementById("healthsel").onchange = function() {
           $("#update1").prop("disabled",false);
           $("#successmsg").hide();
         };
         document.getElementById("projname").oninput = function() {
           checkUpdate5();
           $("#successmsg").hide();
         };
         document.getElementById("projip").oninput = function() {
           $("#successmsg").hide();
         };
         document.getElementById("healthsel_new").onchange = function() {
           $("#successmsg").hide();
         };
         document.getElementById("budgetinput_new").oninput = function() {
           checkUpdate5();
           $("#successmsg").hide();
         };
         document.getElementById("actualsinput_new").oninput = function() {
           checkUpdate5();
           $("#successmsg").hide();
         };
         document.getElementById("committedinput_new").oninput = function() {
           checkUpdate5();
           $("#successmsg").hide();
         };
         document.getElementById("anticipatedinput_new").oninput = function() {
           checkUpdate5();
           $("#successmsg").hide();
         };
         document.getElementById("budgetinput").oninput = function() {
           checkUpdate2();
           $("#successmsg").hide();
         };
         document.getElementById("actualsinput").oninput = function() {
           checkUpdate2();
           $("#successmsg").hide();
         };
         document.getElementById("committedinput").oninput = function() {
           checkUpdate2();
           $("#successmsg").hide();
         };
         document.getElementById("anticipatedinput").oninput = function() {
           checkUpdate2();
           $("#successmsg").hide();
         };
         document.getElementById("delivname").oninput = function() {
           checkUpdate3();
           $("#successmsg").hide();
         };
         document.getElementById("pstart1").onchange = function() {
           checkUpdate3();
           $("#successmsg").hide();
         };
         document.getElementById("pend1").onchange = function() {
           checkUpdate3();
           $("#successmsg").hide();
         };
         document.getElementById("astart1").onchange = function() {
           checkUpdate3();
           $("#successmsg").hide();
         };
         document.getElementById("aend1").onchange = function() {
           if($("#aend1").find("input").val()!="") {
             $("#percent1").val(100);
           }
           checkUpdate3();
           $("#successmsg").hide();
         };
         document.getElementById("percent1").oninput = function() {
           checkUpdate3();
           $("#successmsg").hide();
         };
         document.getElementById("pstart2").onchange = function() {
           checkUpdate4();
           $("#successmsg").hide();
         };
         document.getElementById("pend2").onchange = function() {
           checkUpdate4();
           $("#successmsg").hide();
         };
         document.getElementById("astart2").onchange = function() {
           checkUpdate4();
           $("#successmsg").hide();
         };
         document.getElementById("aend2").onchange = function() {
           if($("#aend2").find("input").val()!="") {
             $("#percent2").val(100);
           }
           checkUpdate4();
           $("#successmsg").hide();
         };
         document.getElementById("percent2").oninput = function() {
           checkUpdate4();
           $("#successmsg").hide();
         };
         function checkUpdate2() {
           var pass = true;
           if($("#budgetinput").val()=="" || $("#budgetinput").val()<0
              || $("#actualsinput").val()=="" || $("#actualsinput").val()<0
              || $("#committedinput").val()=="" || $("#committedinput").val()<0
              || $("#anticipatedinput").val()=="" || $("#anticipatedinput").val()<0) {
             pass = false;
           }
           if(pass) {
             document.getElementById("update2").disabled = false;
           } else {
             document.getElementById("update2").disabled = true;
           }
         };
         function checkUpdate3() {
           var pass = true;
           if($("#delivname").val()=="" || $("#delivname").val()=="- Create new deliverable -") {
             pass = false;
           }
           var pstart1 = $("#pstart1").find("input").val();
           var pend1 = $("#pend1").find("input").val();
           var astart1 = $("#astart1").find("input").val();
           var aend1 = $("#aend1").find("input").val();
           if(pstart1!="" && pend1!="") {
             var d1 = Date.parse(pstart1);
             var d2 = Date.parse(pend1);
             if(d1 > d2) {
               pass = false;
             }
           }
           if(astart1!="" && aend1!="") {
             var d1 = Date.parse(astart1);
             var d2 = Date.parse(aend1);
             if(d1 > d2) {
               pass = false;
             }
           }
           if($("#percent1").val()=="" || $("#percent1").val()<0 || $("#percent1").val()>100) {
             pass = false;
           }
           if(pass) {
             document.getElementById("update3").disabled = false;
           } else {
             document.getElementById("update3").disabled = true;
           }
         };
         function checkUpdate4() {
           var pass = true;
           var pstart2 = $("#pstart2").find("input").val();
           var pend2 = $("#pend2").find("input").val();
           var astart2 = $("#astart2").find("input").val();
           var aend2 = $("#aend2").find("input").val();
           if(pstart2!="" && pend2!="") {
             var d1 = Date.parse(pstart2);
             var d2 = Date.parse(pend2);
             if(d1 > d2) {
               pass = false;
             }
           }
           if(astart2!="" && aend2!="") {
             var d1 = Date.parse(astart2);
             var d2 = Date.parse(aend2);
             if(d1 > d2) {
               pass = false;
             }
           }
           if($("#percent2").val()=="" || $("#percent2").val()<0 || $("#percent2").val()>100) {
             pass = false;
           }
           if(pass) {
             document.getElementById("update4").disabled = false;
           } else {
             document.getElementById("update4").disabled = true;
           }
         };
         function checkUpdate5() {
           var pass = true;
           if($("#projname").val()=="" || $("#projname").val()=="- Create new project -") {
             pass = false;
           }
           if($("#budgetinput_new").val()=="" || $("#budgetinput_new").val()<0
              || $("#actualsinput_new").val()=="" || $("#actualsinput_new").val()<0
              || $("#committedinput_new").val()=="" || $("#committedinput_new").val()<0
              || $("#anticipatedinput_new").val()=="" || $("#anticipatedinput_new").val()<0) {
             pass = false;
           }
           if(pass) {
             document.getElementById("update5").disabled = false;
           } else {
             document.getElementById("update5").disabled = true;
           }
         };'
  )
  
  observeEvent(input$project,{
    if(input$project!="- Create new project -" & input$actionsel=="Update project health") {
      proj.health <- dashboard_sheet[dashboard_sheet$Project==input$project,]$Status[1]
      if(is.na(proj.health)) { proj.health <- "N/A" }
      updateSelectInput(session,inputId="healthsel",selected=proj.health,
                        choices=c("On track","Attention required",
                                  "Immediate attention required","N/A"))
    }
    if(input$project!="- Create new project -" & input$actionsel=="Update budget") {
      bdgt <- as.numeric(budget_sheet[budget_sheet$Type=="Total" & budget_sheet$Project==input$project,
                                      "Budget"]) * 1000
      actl <- as.numeric(budget_sheet[budget_sheet$Type=="Total" & budget_sheet$Project==input$project,
                                      "Actuals"]) * 1000
      comt <- as.numeric(budget_sheet[budget_sheet$Type=="Total" & budget_sheet$Project==input$project,
                                      "Commitment"]) * 1000
      antc <- as.numeric(budget_sheet[budget_sheet$Type=="Total" & budget_sheet$Project==input$project,
                                      "Anticipated"]) * 1000
      updateNumericInput(session,inputId="budgetinput",label="",min=0,step=0.01,value=bdgt)
      updateNumericInput(session,inputId="actualsinput",label="",min=0,step=0.01,value=actl)
      updateNumericInput(session,inputId="committedinput",label="",min=0,step=0.01,value=comt)
      updateNumericInput(session,inputId="anticipatedinput",label="",min=0,step=0.01,value=antc)
    }
    if(input$project!="- Create new project -" & input$actionsel=="Update deliverables") {
      delivs <- schedule_sheet[schedule_sheet$Project==input$project,]$Deliverables
      updateSelectInput(session,inputId="delivsel",
                        choices=c("- Create new deliverable -",delivs))
    }
    runjs(
      paste0(
        'if($("#project").val()=="- Create new project -") {
           $("#actiondiv").hide();
           $("#health").hide();
           $("#budget").hide();
           $("#deliverable").hide();
           $("#projdates1").hide();
           $("#projdates2").hide();
           $("#delete").hide();
           $("#new").show();
           $("#update5").prop("disabled",true);
         } else {
           $("#actiondiv").show();
           $("#health").hide();
           $("#budget").hide();
           $("#deliverable").hide();
           $("#delete").hide();
           if($("#actionsel").val()=="Update project health") {
             $("#health").show();
           }
           if($("#actionsel").val()=="Update budget") {
             $("#budget").show();
           }
           if($("#actionsel").val()=="Update deliverables") {
             $("#deliverable").show();
           }
           if($("#actionsel").val()=="Delete project") {
             $("#delete").show();
           }
           $("#projdates1").hide();
           $("#projdates2").hide();
           $("#new").hide();
         }
         $("#successmsg").hide();'
      )
    )
  })
  
  observeEvent(input$actionsel,{
    if(input$actionsel=="Update project health") {
      proj.health <- dashboard_sheet[dashboard_sheet$Project==input$project,]$Status[1]
      if(is.na(proj.health)) {
        proj.health <- "N/A"
      }
      updateSelectInput(session,inputId="healthsel",selected=proj.health,
                        choices=c("On track","Attention required",
                                  "Immediate attention required","N/A"))
    }
    if(input$actionsel=="Update budget") {
      bdgt <- as.numeric(budget_sheet[budget_sheet$Type=="Total" & budget_sheet$Project==input$project,
                                      "Budget"]) * 1000
      actl <- as.numeric(budget_sheet[budget_sheet$Type=="Total" & budget_sheet$Project==input$project,
                                      "Actuals"]) * 1000
      comt <- as.numeric(budget_sheet[budget_sheet$Type=="Total" & budget_sheet$Project==input$project,
                                      "Commitment"]) * 1000
      antc <- as.numeric(budget_sheet[budget_sheet$Type=="Total" & budget_sheet$Project==input$project,
                                      "Anticipated"]) * 1000
      updateNumericInput(session,inputId="budgetinput",label="",min=0,step=0.01,value=bdgt)
      updateNumericInput(session,inputId="actualsinput",label="",min=0,step=0.01,value=actl)
      updateNumericInput(session,inputId="committedinput",label="",min=0,step=0.01,value=comt)
      updateNumericInput(session,inputId="anticipatedinput",label="",min=0,step=0.01,value=antc)
    }
    if(input$actionsel=="Update deliverables") {
      delivs <- schedule_sheet[schedule_sheet$Project==input$project,]$Deliverables
      updateSelectInput(session,inputId="delivsel",
                        choices=c("- Create new deliverable -",delivs))
    }
  })
  
  observeEvent(input$go2,{
    runjs(
      paste0(
        'if($("#delivsel").val()=="- Create new deliverable -") {
           $("#projdates1").show();
           $("#projdates2").hide();
           $("#update3").prop("disabled",true);
         } else {
           $("#projdates1").hide();
           $("#projdates2").show();
           $("#update4").prop("disabled",true);
         }'
      )
    )
    if(input$delivsel!="- Create new deliverable -") {
      planned.start <- schedule_sheet[schedule_sheet$Project==input$project
                                      & schedule_sheet$Deliverables==input$delivsel,]$Planned.Start[1]
      planned.end <- schedule_sheet[schedule_sheet$Project==input$project
                                    & schedule_sheet$Deliverables==input$delivsel,]$Planned.End[1]
      actual.start <- schedule_sheet[schedule_sheet$Project==input$project
                                     & schedule_sheet$Deliverables==input$delivsel,]$Actual.Start[1]
      actual.end <- schedule_sheet[schedule_sheet$Project==input$project
                                   & schedule_sheet$Deliverables==input$delivsel,]$Actual.End[1]
      completion <- schedule_sheet[schedule_sheet$Project==input$project
                                   & schedule_sheet$Deliverables==input$delivsel,]$Completion[1]
      updateDateInput(session,inputId="pstart2",label="",value=planned.start)
      updateDateInput(session,inputId="pend2",label="",value=planned.end)
      updateDateInput(session,inputId="astart2",label="",value=actual.start)
      updateDateInput(session,inputId="aend2",label="",value=actual.end)
      updateNumericInput(session,inputId="percent2",label="",value=completion,
                         min=0,max=100,step=1)
    }
  })
  
  observeEvent(input$update1,{
    if(input$healthsel!="N/A") {
      dashboard_sheet[dashboard_sheet$Project==input$project,"Status"] <- input$healthsel
    } else {
      dashboard_sheet[dashboard_sheet$Project==input$project,"Status"] <- NA
    }
    runjs('$("#successmsg").show();
           $("#update1").prop("disabled",true);')
    
    write.csv(dashboard_sheet,"health.csv",na="",row.names=FALSE)
    dashboard_sheet <<- read.csv("health.csv",header=TRUE,na.strings=c(""))
    dashboard_sheet$Project <<- as.character(dashboard_sheet$Project)
    dashboard_sheet$IP <<- as.character(dashboard_sheet$IP)
    dashboard_sheet$Status <<- as.character(dashboard_sheet$Status)
  })
  
  observeEvent(input$update2,{
    name <- input$project
    if(name %in% budget_sheet$Project) {
      budget_sheet[budget_sheet$Project==name,"Budget"] <- round(input$budgetinput/1000,0)
      budget_sheet[budget_sheet$Project==name,"Actuals"] <- round(input$actualsinput/1000,0)
      budget_sheet[budget_sheet$Project==name,"Commitment"] <- round(input$committedinput/1000,0)
      budget_sheet[budget_sheet$Project==name,"Anticipated"] <- round(input$anticipatedinput/1000,0)
      budget_sheet[budget_sheet$Project==name,"Total.Forecast"] <-
        round(input$actualsinput/1000,0) + round(input$committedinput/1000,0) +
        round(input$anticipatedinput/1000,0)
    } else {
      d <- data.frame(Project=c(name),Type=c("Total"),Budget=c(input$budgetinput/1000),
                      Actuals=c(round(input$actualsinput/1000,0)),
                      Commitment=c(round(input$committedinput/1000,0)),
                      Anticipated=c(round(input$anticipatedinput/1000,0)),
                      Total.Forecast=c(round(input$actualsinput/1000,0) +
                                         round(input$committedinput/1000,0) +
                                         round(input$anticipatedinput/1000,0)))
      budget_sheet <- rbind(budget_sheet,d)
    }
    runjs('$("#successmsg").show();
           $("#update2").prop("disabled",true);')
    
    write.csv(budget_sheet,"budget.csv",na="",row.names=FALSE)
    budget_sheet <<- read.csv("budget.csv",header=TRUE,na.strings=c(""))
    budget_sheet$Project <<- as.character(budget_sheet$Project)
    budget_sheet$Type <<- as.character(budget_sheet$Type)
    for(col in c("Budget","Actuals","Commitment","Anticipated","Total.Forecast")) {
      budget_sheet[is.na(budget_sheet[,col]),col] <<- 0
    }
  })
  
  observeEvent(input$update3,{
    name1 <- input$project
    name2 <- input$delivname
    pstart <- input$pstart1
    if(!isTruthy(pstart)) { pstart <- NA }
    pend <- input$pend1
    if(!isTruthy(pend)) { pend <- NA }
    astart <- input$astart1
    if(!isTruthy(astart)) { astart <- NA }
    aend <- input$aend1
    if(!isTruthy(aend)) { aend <- NA }
    compl <- input$percent1
    
    if(name1 %in% schedule_sheet$Project
       & name2 %in% schedule_sheet[schedule_sheet$Project==name1,]$Deliverables) {
      schedule_sheet[schedule_sheet$Project==name1
                     & schedule_sheet$Deliverables==name2,"Planned.Start"] <- pstart
      schedule_sheet[schedule_sheet$Project==name1
                     & schedule_sheet$Deliverables==name2,"Planned.End"] <- pend
      schedule_sheet[schedule_sheet$Project==name1
                     & schedule_sheet$Deliverables==name2,"Actual.Start"] <- astart
      schedule_sheet[schedule_sheet$Project==name1
                     & schedule_sheet$Deliverables==name2,"Actual.End"] <- aend
      schedule_sheet[schedule_sheet$Project==name1
                     & schedule_sheet$Deliverables==name2,"Completion"] <- compl
    } else {
      d <- data.frame(Project=c(name1),Deliverables=c(name2),Planned.Start=c(pstart),
                      Planned.End=c(pend),Actual.Start=c(astart),Actual.End=c(aend),
                      Completion=c(compl))
      schedule_sheet <- rbind(schedule_sheet,d)
    }
    runjs('$("#successmsg").show();
           $("#update3").prop("disabled",true);')
    
    write.csv(schedule_sheet,"progress.csv",na="",row.names=FALSE)
    schedule_sheet <<- read.csv("progress.csv",header=TRUE,na.strings=c(""))
    schedule_sheet$Project <<- as.character(schedule_sheet$Project)
    schedule_sheet$Deliverables <<- as.character(schedule_sheet$Deliverables)
    schedule_sheet$Planned.Start <<- as.Date(schedule_sheet$Planned.Start,"%Y-%m-%d",tz="UTC")
    schedule_sheet$Planned.End <<- as.Date(schedule_sheet$Planned.End,"%Y-%m-%d",tz="UTC")
    schedule_sheet$Actual.Start <<- as.Date(schedule_sheet$Actual.Start,"%Y-%m-%d",tz="UTC")
    schedule_sheet$Actual.End <<- as.Date(schedule_sheet$Actual.End,"%Y-%m-%d",tz="UTC")
    updateSelectInput(session,inputId="delivsel",label="",
                      choices=c("- Create new deliverable -",
                                schedule_sheet[schedule_sheet$Project==name1,]$Deliverables))
  })
  
  observeEvent(input$update4,{
    name1 <- input$project
    name2 <- input$delivsel
    pstart <- input$pstart2
    if(!isTruthy(pstart)) { pstart <- NA }
    pend <- input$pend2
    if(!isTruthy(pend)) { pend <- NA }
    astart <- input$astart2
    if(!isTruthy(astart)) { astart <- NA }
    aend <- input$aend2
    if(!isTruthy(aend)) { aend <- NA }
    compl <- input$percent2
    
    schedule_sheet[schedule_sheet$Project==name1
                   & schedule_sheet$Deliverables==name2,"Planned.Start"] <- pstart
    schedule_sheet[schedule_sheet$Project==name1
                   & schedule_sheet$Deliverables==name2,"Planned.End"] <- pend
    schedule_sheet[schedule_sheet$Project==name1
                   & schedule_sheet$Deliverables==name2,"Actual.Start"] <- astart
    schedule_sheet[schedule_sheet$Project==name1
                   & schedule_sheet$Deliverables==name2,"Actual.End"] <- aend
    schedule_sheet[schedule_sheet$Project==name1
                   & schedule_sheet$Deliverables==name2,"Completion"] <- compl
    
    runjs('$("#successmsg").show();
           $("#update4").prop("disabled",true);')
    
    write.csv(schedule_sheet,"progress.csv",na="",row.names=FALSE)
    schedule_sheet <<- read.csv("progress.csv",header=TRUE,na.strings=c(""))
    schedule_sheet$Project <<- as.character(schedule_sheet$Project)
    schedule_sheet$Deliverables <<- as.character(schedule_sheet$Deliverables)
    schedule_sheet$Planned.Start <<- as.Date(schedule_sheet$Planned.Start,"%Y-%m-%d",tz="UTC")
    schedule_sheet$Planned.End <<- as.Date(schedule_sheet$Planned.End,"%Y-%m-%d",tz="UTC")
    schedule_sheet$Actual.Start <<- as.Date(schedule_sheet$Actual.Start,"%Y-%m-%d",tz="UTC")
    schedule_sheet$Actual.End <<- as.Date(schedule_sheet$Actual.End,"%Y-%m-%d",tz="UTC")
  })
  
  observeEvent(input$update5,{
    name <- input$projname
    if(name %in% dashboard_sheet$Project) {
      if(input$projip=="") {
        dashboard_sheet[dashboard_sheet$Project==name,"IP"] <- NA
      } else {
        dashboard_sheet[dashboard_sheet$Project==name,"IP"] <- input$projip
      }
      if(input$healthsel_new!="N/A") {
        dashboard_sheet[dashboard_sheet$Project==name,"Status"] <- input$healthsel_new
      }
    } else {
      if(input$healthsel_new=="N/A" & input$projip=="") {
        d <- data.frame(Project=c(name),IP=NA,Status=NA)
      } else if(input$healthsel_new=="N/A") {
        d <- data.frame(Project=c(name),IP=c(input$projip),Status=NA)
      } else if(input$projip=="") {
        d <- data.frame(Project=c(name),IP=NA,Status=input$healthsel_new)
      } else {
        d <- data.frame(Project=c(name),IP=c(input$projip),Status=c(input$healthsel_new))
      }
      dashboard_sheet <- rbind(dashboard_sheet,d)
    }
    if(name %in% budget_sheet$Project) {
      budget_sheet[budget_sheet$Project==name,"Budget"] <- round(input$budgetinput_new/1000,0)
      budget_sheet[budget_sheet$Project==name,"Actuals"] <- round(input$actualsinput_new/1000,0)
      budget_sheet[budget_sheet$Project==name,"Commitment"] <- round(input$committedinput_new/1000,0)
      budget_sheet[budget_sheet$Project==name,"Anticipated"] <- round(input$anticipatedinput_new/1000,0)
      budget_sheet[budget_sheet$Project==name,"Total.Forecast"] <-
        round(input$actualsinput_new/1000,0) + round(input$committedinput_new/1000,0) +
        round(input$anticipatedinput_new/1000,0)
    } else {
      d <- data.frame(Project=c(name),Type=c("Total"),Budget=c(input$budgetinput_new/1000),
                      Actuals=c(round(input$actualsinput_new/1000,0)),
                      Commitment=c(round(input$committedinput_new/1000,0)),
                      Anticipated=c(round(input$anticipatedinput_new/1000,0)),
                      Total.Forecast=c(round(input$actualsinput_new/1000,0) +
                                         round(input$committedinput_new/1000,0) +
                                         round(input$anticipatedinput_new/1000,0)))
      budget_sheet <- rbind(budget_sheet,d)
    }
    runjs('$("#successmsg").show();
           $("#update5").prop("disabled",true);')
    
    write.csv(dashboard_sheet,"health.csv",na="",row.names=FALSE)
    dashboard_sheet <<- read.csv("health.csv",header=TRUE,na.strings=c(""))
    dashboard_sheet$Project <<- as.character(dashboard_sheet$Project)
    dashboard_sheet$IP <<- as.character(dashboard_sheet$IP)
    dashboard_sheet$Status <<- as.character(dashboard_sheet$Status)
    updateSelectInput(session,inputId="project",label="",
                      choices=c("- Create new project -",dashboard_sheet$Project))
    updateSelectInput(session,inputId='selectproject',label="Select a Project",
                      choices=c('All',dashboard_sheet$Project))
    
    write.csv(budget_sheet,"budget.csv",na="",row.names=FALSE)
    budget_sheet <<- read.csv("budget.csv",header=TRUE,na.strings=c(""))
    budget_sheet$Project <<- as.character(budget_sheet$Project)
    budget_sheet$Type <<- as.character(budget_sheet$Type)
    for(col in c("Budget","Actuals","Commitment","Anticipated","Total.Forecast")) {
      budget_sheet[is.na(budget_sheet[,col]),col] <<- 0
    }
  })
  
  observeEvent(input$del,{
    name <- input$project
    dashboard_sheet <- dashboard_sheet[dashboard_sheet$Project!=name,]
    budget_sheet <- budget_sheet[budget_sheet$Project!=name,]
    schedule_sheet <- schedule_sheet[schedule_sheet$Project!=name,]
    
    write.csv(dashboard_sheet,"health.csv",na="",row.names=FALSE)
    dashboard_sheet <<- read.csv("health.csv",header=TRUE,na.strings=c(""))
    dashboard_sheet$Project <<- as.character(dashboard_sheet$Project)
    dashboard_sheet$IP <<- as.character(dashboard_sheet$IP)
    dashboard_sheet$Status <<- as.character(dashboard_sheet$Status)
    
    write.csv(budget_sheet,"budget.csv",na="",row.names=FALSE)
    budget_sheet <<- read.csv("budget.csv",header=TRUE,na.strings=c(""))
    budget_sheet$Project <<- as.character(budget_sheet$Project)
    budget_sheet$Type <<- as.character(budget_sheet$Type)
    for(col in c("Budget","Actuals","Commitment","Anticipated","Total.Forecast")) {
      budget_sheet[is.na(budget_sheet[,col]),col] <<- 0
    }
    
    write.csv(schedule_sheet,"progress.csv",na="",row.names=FALSE)
    schedule_sheet <<- read.csv("progress.csv",header=TRUE,na.strings=c(""))
    schedule_sheet$Project <<- as.character(schedule_sheet$Project)
    schedule_sheet$Deliverables <<- as.character(schedule_sheet$Deliverables)
    schedule_sheet$Planned.Start <<- as.Date(schedule_sheet$Planned.Start,"%Y-%m-%d",tz="UTC")
    schedule_sheet$Planned.End <<- as.Date(schedule_sheet$Planned.End,"%Y-%m-%d",tz="UTC")
    schedule_sheet$Actual.Start <<- as.Date(schedule_sheet$Actual.Start,"%Y-%m-%d",tz="UTC")
    schedule_sheet$Actual.End <<- as.Date(schedule_sheet$Actual.End,"%Y-%m-%d",tz="UTC")
    
    updateSelectInput(session,inputId="project",label="",
                      choices=c("- Create new project -",dashboard_sheet$Project))
    updateSelectInput(session,inputId='selectproject',label="Select a Project",
                      choices=c('All',dashboard_sheet$Project))
  })
  
  #Method called when someone select a new project in the drop down menu. This method updates the title 
  #at the top of the page that says "Project:insertProjectName" in big font. 
  output$project_name<-renderUI({
    project_name <- paste0('Project: ',input$selectproject)
    h1(project_name, 
       style = "font-family:'Arial'; margin-left:17px;
        font-weight: 500; line-height: 1.1; 
        color: #2E4053;")
  })
  
  #Method called when someone selects a new project in the drop down menu. It returns the project name which is used throughout 
  #the server logic to determine which project(s) are currently selected /which ones should and shouldn't be filtered.
  project_selected<-reactive({
    
    if(input$selectproject=='All') {
      project_names<-dashboard_sheet$Project
    } else {
      project_names<-dashboard_sheet$Project[dashboard_sheet$Project==input$selectproject]
    }
    return(list(project_names=project_names))
  })

  #Method called when someone selects a new project in the drop down menu. This method creates the schedule time plot graph
  #that displays the difference between a project deliverable's Planned End and Actual End date. Note: If a project deliverable
  #does not have both a Planned End and Actual End date, it will not be ploted on the timeline. 
  output$schedule_plt<-renderTimevis({
   
    schedule_df <- filter(schedule_sheet,Project %in% project_selected()$project_names
                          & !is.na(Actual.End)
                          & !is.na(Actual.Start))
    if(nrow(schedule_df)==0) {
      data <- data.frame(id=c(),content=c(),start=c(),end=c())
    } else {
      data <- data.frame(
        id=1:nrow(schedule_df),
        content=schedule_df$Deliverables,
        start=schedule_df$Actual.Start,
        end=schedule_df$Actual.End
      )
    }
    timevis(data)
  })
  
  #Method called when someone selects a new project in the drop down menu. This method creates the data table that is right underneath
  #the timeplot. This table should the planned end and actual end of the actual project. This is down by taking the 
  #oldest planned and actual end date. This is assumed to be equivalent to the project's end dates. These dates are then displayed

  output$schedule_tbl<-DT::renderDataTable({
    schedule_df <- schedule_sheet %>%
            filter(Project %in% project_selected()$project_names)%>% #Filters out the unselected project 
            group_by("Project"=Project)%>% #groups the data by project name
            summarise("Planned End"=suppressWarnings(max(na.omit(Planned.End))))
    if(nrow(schedule_df)==0) {
      DT::datatable(data.frame(Project=c(),"Planned End"=c(),"Actual End"=c()),
                    options=list(dom='tip'),rownames=FALSE)
    } else {
      schedule_df$`Actual End` <- NA
      for(proj in schedule_df$Project) {
        avg <- mean(schedule_sheet[schedule_sheet$Project==proj,]$Completion,na.rm=TRUE)
        latest <- suppressWarnings(max(na.omit(schedule_sheet[schedule_sheet$Project==proj,]$Actual.End)))
        if(avg >= 100) {
          schedule_df$`Actual End`[schedule_df$Project==proj] <- as.character(latest)
        } else {
          schedule_df$`Actual End`[schedule_df$Project==proj] <- NA
        }
      }
      DT::datatable(schedule_df,options=list(dom='tip'),rownames=FALSE) #Creates the table using the data frame 
    }
  })

  #Method called when someone selects a new project in the drop down menu. This method creates the bar graph of the project's 
  #overall health. This info is inside the Dashboard sheet in 2 columsn 'Overall Project Health' and 'Status'
  output$project_health_plt<-renderPlot({
    cols<-c('On track'='#03B150','Attention required'='#FFC000','Immediate attention required'='#C01900')
    health_df<-dashboard_sheet%>%filter(Project==project_selected()$project_names)%>% #filters out the unselected projects
      filter(!is.na(Status))%>% #filters out the empty overall project helath cells. 
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
    suppressWarnings(print(p))
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
        Forecast <- sum(budget_sheet$Total.Forecast)
        budget_df <- melt(data.frame(Project,Forecast,Actuals), id.vars="Project")
      
      }
      else{
        #If the user has selected a specific project in the drop down menu, then the data is filtered to 
        #get the data of the specific project. Only the 3 columns that are relevant are selected
        #project, total forecast and actuals. That data is then melted the same way that the data is melted 
        #when the user selects all projects.
        df <- budget_sheet %>%
            filter(Project==project_selected()$project_names) 
        budget_df <- melt(df[,c("Project","Total.Forecast","Actuals")], id.vars="Project")
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
      suppressWarnings(print(p))
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
        Variance <- sum(budget_sheet$Total.Forecast - budget_sheet$Budget)
        Forecast <- sum(budget_sheet$Total.Forecast)
        budget_df <- reshape2::melt(data.frame(Project,Forecast,Variance), id.vars="Project") 
      
      }
      else{
        #If the user has selected a specific project in the drop down menu, then the data is filtered to 
        #get the data of the specific project. Only the 3 columns that are relevant are selected
        #project, total variance and actuals. That data is then melted the same way that the data is melted 
        #when the user selects all projects.
        
        df <- budget_sheet %>%
            filter(Project==project_selected()$project_names)
        df$Variance <- df$Total.Forecast - df$Budget
        budget_df <- reshape2::melt(df[,c("Project","Total.Forecast","Variance")], id.vars="Project")
      }
    
      p <- ggplot(budget_df,  aes(x=input$selectproject, y=value)) + geom_bar(aes(fill = variable), # #Adds the bars to the graph
      width = 0.4, position = position_dodge(width=0.5), stat="identity") + #sets width and position of bars
      theme_minimal() + #uses a predefined minimal theme to that places replaced the default grey bg of the graph with white.
      theme(legend.position="top", #sets the legend position to be at the top 
            legend.title=element_blank(), #sets the legend title to blank
            axis.title.x=element_blank(), #sets the x axis title to blank
            axis.title.y=element_blank()) #sets the y axis title to blank
      suppressWarnings(print(p))
    })
})
