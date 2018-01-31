#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)

# Get data
# Data from https://www.lendingclub.com/info/download-data.action          
loans <- read.csv("F:/Professional Development/coursera_data_products/coursera_data_products_course_project/coursera_data_products_course_project_app/LoanStats3a.csv", 
                  stringsAsFactors = FALSE)

# Format data
loans <- subset(loans, (loan_status == "Charged Off" |
                                loan_status == "Fully Paid") &
                        !is.na(loan_amnt), 
                select = c("loan_amnt", "int_rate", "grade", "loan_status"))

loans$int_rate <- round(as.numeric(gsub("%", "", loans$int_rate)), 1)
loans$loan_status <- as.factor(loans$loan_status)

# Create plot
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    filtered <-
            loans %>%
            filter(loan_amnt >= input$amountInput[1],
                   loan_amnt <= input$amountInput[2],
                   loan_status == input$statusInput
            )
    ggplot(filtered, aes(x = loan_amnt, y = int_rate, color = grade, shape = loan_status)) +
            geom_point(size = 2)
    
  })
  
})
