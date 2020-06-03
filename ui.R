library(shiny)
library(ggbiplot)
library(shinythemes)
library(shinydashboard)
library(tibble)
library(dplyr)
library(highcharter)
library(DT)
library(lubridate)
library(tidyr)
library(shinyWidgets)
#library(tychobratools)  
library(openxlsx)

names(fb_total)[14:20] <- c(7,1,2,3,4,5,6)
fb_total2 <-  fb_total %>%
  gather(key = "week",
         value = "cases",
         names(fb_total)[14:20] )
fb_total2 <- fb_total2 %>% filter( cases == 1)
fb_total_week <- fb_total2[,-ncol(fb_total2)]
pub_weekday <-as.data.frame(table(fb_total_week$week))
pub_weekday$Var1<-c('Mon','Tue','Wed','Thur','Fri','Sat','Sun')
fb_total_week$week <- as.factor(fb_total_week$week)

shinyUI(

dashboardPage(

  #-----------------------------dashboardHeader----------------------
  dashboardHeader(title = "Fb Comments Volume Analysis ",
                  # Dropdown menu for messages
                  dropdownMenu(type = "messages", badgeStatus = "success",
                               messageItem("Support Team",
                                           "This is the content of a message.",
                                           time = "5 mins"
                               ),
                               messageItem("Support Team",
                                           "This is the content of another message.",
                                           time = "2 hours"
                               ),
                               messageItem("New User",
                                           "Can I get some help?",
                                           time = "Today"
                               )
                  ),
                  
                  # Dropdown menu for notifications
                  dropdownMenu(type = "notifications", badgeStatus = "warning",
                               notificationItem(icon = icon("users"), status = "info",
                                                "5 new members joined today"
                               ),
                               notificationItem(icon = icon("warning"), status = "danger",
                                                "Resource usage near limit."
                               ),
                               notificationItem(icon = icon("shopping-cart", lib = "glyphicon"),
                                                status = "success", "25 sales made"
                               ),
                               notificationItem(icon = icon("user", lib = "glyphicon"),
                                                status = "danger", "You changed your username"
                               )
                  ),
                  
                  # Dropdown menu for tasks, with progress bar
                  dropdownMenu(type = "tasks", badgeStatus = "danger",
                               taskItem(value = 80, color = "aqua",
                                        "github "
                               ),
                               taskItem(value = 40, color = "green",
                                        "Design new layout"
                               ),
                               taskItem(value = 60, color = "yellow",
                                        "Another task"
                               ),
                               taskItem(value = 50, color = "red",
                                        "Write documentation"
                               )
                  )),
  #-----------------------------dashboardSidebar-------------------------------------
dashboardSidebar(
    sidebarMenu(id = "sidebar",
      menuItem("Data summary", tabName = "datasummary", icon = icon("adjust")),
      menuItem("Data view", tabName = "dataview", icon = icon("folder")),
      menuItem("Model", tabName = "datamodel", icon = icon("folder")),
      menuItem("cleaning", tabName = "dataweek" , icon = icon("th"), 
               badgeLabel = "new", badgeColor = "green"), #badgeLabel add(new icon)
      menuItem("article", tabName = "dataarticle", icon = icon("folder")),
      menuItem("content", tabName = "datacontent", icon = icon("folder")),
      
      
       menuItem("Github", icon = icon("file-code-o"), 
               href = "https://github.com/1072-datascience/finalproject-1072ds_group5") 
      #open when finish
      )
  ),

#--------------------------------dashboardBody----------------------------------
dashboardBody(
  tabItems(
    tabItem(
    tabName = "dataview",
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(plotOutput("plot1", height = 250)),
      box(
        title = "Controls",
        sliderInput("slider", "Number of observations:", 1, 100, 50),
        
        tabItem(tabName = "widgets",
                h2("Widgets tab content")
        )
      )
    )
    ),
  #------------------model------------------
    tabItem(
      tabName = "datamodel",
      # Boxes need to be put in a row (or column)
      
      pageWithSidebar(
        
        # Application title
        headerPanel("Data Summary 粉專資訊"),
        
        # Sidebar with controls to select the random distribution type
        # and number of observations to generate. Note the use of the br()
        # element to introduce extra vertical spacing
        sidebarPanel(
          radioButtons("variable", "Variable:",
                       list("讚數" = 'likes',
                            "打卡次數" = "Checkins",
                            "按讚＋留言＋分享" = 'talking_about',
                            "粉專類型" = "Category")),
          br()
        ),
        # Show a tabset that includes a plot, summary, and table view
        # of the generated distribution
        
        mainPanel(
          tabsetPanel(
            tabPanel("Histogram", plotOutput("histogram")), 
            tabPanel("Summary", verbatimTextOutput("summary")),
            tabPanel("Boxplot", plotOutput("boxplot")),
            tabPanel("Bar graph", plotOutput("bar"))
          )
        )
      )
      
 

      ),
  #------------------week------------------    
    tabItem(
      tabName = "dataweek",
      # Boxes need to be put in a row (or column)
      box(plotOutput("plot1", height = 250)),
      box(
        title = "Publish Weekday histogram of Total Comments of FB Dataset",
        sliderInput(inputId = 'num',label='Weekday',value=5,min=1,max=7)
      ),
        # Show a plot of the generated distribution
        mainPanel(
          plotOutput("histgram")
        )
      ),
    #------------------article------------------    
    tabItem(
      tabName = "dataarticle",
      pageWithSidebar(
        
        # Application title
        headerPanel("Data Summary 文章留言數資訊"),
        
        # Sidebar with controls to select the random distribution type
        # and number of observations to generate. Note the use of the br()
        # element to introduce extra vertical spacing
        sidebarPanel(
          radioButtons("variable", "Variable:",
                       list("留言數（base以前）" = 'Comments_before_Base',
                            "留言數（24~base）" = "Comments_24_base",
                            "留言數（24~48）" = 'Comments_24_48',
                            "留言數（發文後24但在截止日前）" = "Comments_first_24",
                            '在未來H內的留言數' = 'Comments_H')),
          br()
        ),
        # Show a tabset that includes a plot, summary, and table view
        # of the generated distribution
        
        
        mainPanel(
          tabsetPanel(
            tabPanel("Histogram", plotOutput("histogram")), 
            tabPanel("Summary", verbatimTextOutput("summary")),
            tabPanel("Boxplot", plotOutput("boxplot")),
            tabPanel("Bar graph", plotOutput("bar"))
          )
        )
      )
    ),
#------------------content------------------
    tabItem(
      tabName = "datacontent",
      pageWithSidebar(
        
        # Application title
        headerPanel("Data Summary 文章文案資訊"),
        
        # Sidebar with controls to select the random distribution type
        # and number of observations to generate. Note the use of the br()
        # element to introduce extra vertical spacing
        sidebarPanel(
          radioButtons("variable", "Variable:",
                       c("字元數" = "Post_length",
                            "分享數" = "Post_Share_Count")),
          br()
        ),
        # Show a tabset that includes a plot, summary, and table view
        # of the generated distribution
        
        mainPanel(type = "tabs",
          tabsetPanel(
            tabPanel("Histogram", plotOutput("histogramcon")), 
            tabPanel("Summary", verbatimTextOutput("summarycon")),
            tabPanel("Boxplot", plotOutput("boxplotcon")),
            tabPanel("Bar graph", plotOutput("barcon"))
          )
        )
      )
    )
)),


#------------------------------------------------------------------
  skin = "black",
))