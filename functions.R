#Functions.R contains helper functions
#You can place complex functions inside this file inorder to reduce the number of lines of code
#inside the Server.R file.
#This functions can be used the same as an other functions inside of the other files Eg. The server.R file

#Creates a timeline graph that splits the dates up by quarters 
timeplot<-function(df){
  
  #list of the different project completion statuses
  status_levels <- c("Early", "3-6 Months", "6+ Months","No Change")
  #list of containging a list of colours that correspond to each different project compleion status
  status_colours <- c( "#00B050", "#FFC000", "#C00000","#000000")

  #Converts the schedule health column to factors.
  #Learn more about factors: 
  #Article explanation: https://swcarpentry.github.io/r-novice-inflammation/12-supp-factors/
  #
  #R documentation: https://www.rdocumentation.org/packages/base/versions/3.5.3/topics/factor
 
  df$Schedule.Health <- factor(df$Schedule.Health, levels=status_levels, ordered=TRUE, exclude=NA)
  print(df$Schedule.Health)
  
  #sets the position of the points on the timeline
  positions <- c(0.3, -0.3, 0.5, -0.5,0.9,-0.9,1.2, -1.2)
  directions <- c(1, -1) #sets the direction of the vertical lines on the line (they alternate from point up /down)
  
  #Creates 3 new columns with information about line positions for the data. This will be combined with our original excel
  #data
  line_pos <- data.frame(
    "date"=sort(unique(df$Actual.End),na.last=T),
    "position"=rep(positions, length.out=length(unique(df$Actual.End))), 
    "direction"=rep(directions, length.out=length(unique(df$Actual.End))) #this makes the directions of the lines alternate between poining upwards and poinint downwards
  )
  
  #Joins the excel data sheet with the line_pos data frame created.
  df<-left_join(df,line_pos,by=c('Actual.End'='date'))
  #offses text
  text_offset <- 0.1 

  #calculates the average 
  df$month_count <- ave(df$Actual.End==df$Actual.End, df$Actual.End, FUN=cumsum)
  #calculates where the position of the text should be
  df$text_position <- (df$month_count * text_offset * df$direction) + df$position
  
  #Sets the month buffer to 4 (Q1,Q2,Q3,Q4)
  month_buffer <- 4

  #The following methods are responsible for getting the min / max dates to be used on the timeline and formatting the data 
  #accordingly 
  month_date_range <- seq(min(df$Actual.End,na.rm=T) - months(month_buffer), max(df$Actual.End,na.rm=T) + months(month_buffer), by='month')
  month_df <- data.frame(month_date_range) #
  month_df$month_format <- paste0(year(month_df$month_date_range),' ',quarters(month_df$month_date_range)) 
  month_df$month_format<-ifelse(month_df$month_format==lead(month_df$month_format,default=''),'',month_df$month_format) 
  
  #plots the time plot graph
  timeline_plot<-ggplot(df,aes(x=Actual.End,y=0,label="Project",color=Schedule.Health))+
    labs(col="Milestones")+ 
    theme_classic()
  timeline_plot<-timeline_plot+scale_color_manual(values=status_colours, labels=status_levels, drop = FALSE)
  
  # Plot horizontal black line for timeline
  timeline_plot<-timeline_plot+geom_hline(yintercept=0, color = "black", size=0.3)
  
  # Plot vertical segment lines for milestones
  timeline_plot<-timeline_plot+geom_segment(data=df[df$month_count == 1,], aes(y=position,yend=0,xend=Actual.End), color='black', size=0.2)
  
  # Plot scatter points at zero and date
  timeline_plot<-timeline_plot+geom_point(aes(y=0), size=3)
  
  # Don't show axes, appropriately position legend
  timeline_plot<-timeline_plot+theme(axis.line.y=element_blank(),
                                     axis.text.y=element_blank(), 
                                     axis.title.x=element_blank(),
                                     axis.title.y=element_blank(),
                                     axis.ticks.y=element_blank(),
                                     axis.text.x =element_blank(),
                                     axis.ticks.x =element_blank(),
                                     axis.line.x =element_blank())
                                     #legend.position='bottom')
  
  # Show text for each month
  timeline_plot<-timeline_plot+geom_text(data=month_df, aes(x=month_date_range,y=-0.1,label=month_format),size=3,vjust=0.5, color='black')
  # Show text for each milestone
  timeline_plot<-timeline_plot+geom_text(aes(y=text_position,label=paste(Project,Deliverables,sep=": ")),size=3)
  
  return(timeline_plot)
  #ggplotly(timeline_plot,height=450,tooltip=NULL)
}
