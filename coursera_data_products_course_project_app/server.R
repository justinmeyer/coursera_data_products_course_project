#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # Get data
    loans <- read.csv("F:/Professional Development/coursera_data_products/coursera_data_products_course_project/coursera_data_products_course_project_app/LoanStats3a.csv")

    # Format data
    loans <- subset(loans, !is.na(loan_amnt))
    
    # generate bins based on input$bins from ui.R
    x <- loans$loan_amnt
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
