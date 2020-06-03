
fb_total <- read.csv("fb_data_total.csv" , header = T)

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

 
Page_Popularity.likes<-fb_total_week$Page_likes
Page_Checkins<-fb_total_week$Page_Checkins
Page_talking_about<-fb_total_week$Page_talking_about
Page_Category<-table(fb_total_week$Page_Category)

Comments_before_Base<-fb_total_week$total_comments
Comments_24_base<-fb_total_week$no_of_comments_24_base
Comments_24_48<-fb_total_week$no_of_comments_48_24
Comments_first_24<-fb_total_week$no_of_comments_first_24
Comments_H<-fb_total_week$Target.Variable.

Post_length<-fb_total_week$Post_length
Post_Share_Count<-fb_total_week$Post.Share.Count


function(input, output,session){
  
#-------------------------View-------------  
  output$plot1 <- renderPlot({
   hist(fb_total$Page_likes)})
  
#-------------------------model-------------
  data <- reactive({  
    variable <- switch(input$variable,
                       likes = Page_Popularity.likes,
                       Checkins = Page_Checkins,
                       talking_about = Page_talking_about,
                       Category = Page_Category)
  })
  
  # Generate a plot of the data. Also uses the inputs to build the 
  # plot label. Note that the dependencies on both the inputs and
  # the 'data' reactive expression are both tracked, and all expressions 
  # are called in the sequence implied by the dependency graph
  output$histogram <- renderPlot({
    hist(data(),main = as.character(input$variable))
  })
  
  # Generate a summary of the data
  output$summary <- renderPrint({
    summary(data())
  })
  #boxplot
  output$boxplot <- renderPlot({
    boxplot(data(),main = as.character(input$variable))
  })
  #barplot
  output$bar<-renderPlot({
    barplot(data(),main = as.character(input$variable))
  })
  
#----------------------article---------------------------
  data <- reactive({  
    variable <- switch(input$variable,
                       Comments_before_Base = Comments_before_Base,
                       Comments_24_base = Comments_24_base,
                       Comments_24_48 = Comments_24_48 ,
                       Comments_first_24 = Comments_first_24,
                       Comments_H = Comments_H)
  })
  
  # Generate a plot of the data. Also uses the inputs to build the 
  # plot label. Note that the dependencies on both the inputs and
  # the 'data' reactive expression are both tracked, and all expressions 
  # are called in the sequence implied by the dependency graph
  output$histogram <- renderPlot({
    hist(data(),main = as.character(input$variable))
  })
  
  # Generate a summary of the data
  output$summary <- renderPrint({
    summary(data())
  })
  #boxplot
  output$boxplot <- renderPlot({
    boxplot(data(),main = as.character(input$variable))
  })
  #barplot
  output$bar<-renderPlot({
    barplot(data(),main = as.character(input$variable))
  })

#------------------------content-----------------------------------
  data <- reactive({  
    variable <- switch(input$variable,
                       Post_length = Post_length,
                       Post_Share_Count = Post_Share_Count)
  })
  
  # Generate a plot of the data. Also uses the inputs to build the 
  # plot label. Note that the dependencies on both the inputs and
  # the 'data' reactive expression are both tracked, and all expressions 
  # are called in the sequence implied by the dependency graph
  output$histogramcon <- renderPlot({
    hist(data(),main = as.character(input$variable),col = "#75AADB", border = "white")
  })
  
  # Generate a summary of the data
  output$summarycon <- renderTable({
    summary(data())
  })
  #boxplot
  output$boxplotcon <- renderPlot({
    boxplot(data(),main = as.character(input$variable))
  })
  #barplot
  output$barcon<-renderPlot({
    barplot(data(),main = as.character(input$variable))
  })
  
  
  
}
 
  
  
  
 
