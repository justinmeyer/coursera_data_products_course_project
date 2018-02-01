# server.r

library(shiny)
library(ggplot2)
library(dplyr)

# Get data
# Data from https://www.lendingclub.com/info/download-data.action, select 2007-2011 data.        
loans <- read.csv("C:/Users/Toshiba1/Documents/Professional Development/Coursera - Data Products/course_project/coursera_data_products_course_project/LoanStats3a.csv", 
                  skip = 1,
                  stringsAsFactors = FALSE)

# Format data
loans <- subset(loans, (loan_status == "Charged Off" |
                                loan_status == "Fully Paid") &
                        !is.na(loan_amnt), 
                select = c("loan_amnt", "int_rate", "grade", "loan_status", "dti", "installment", "issue_d"))

loans$int_rate <- round(as.numeric(gsub("%", "", loans$int_rate)), 1)
loans$loan_status <- as.factor(loans$loan_status)

loans$year <- as.numeric(substr(loans$issue_d, 5, 8))
loans$issue_d <- NULL

# Create plot
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # Filter data as per inputs
    filtered <-
            loans %>%
            filter(loan_amnt >= input$amountInput[1],
                   loan_amnt <= input$amountInput[2],
                   installment >= input$installmentInput[1],
                   installment <= input$installmentInput[2],
                   dti >= input$dtiInput[1],
                   dti <= input$dtiInput[2],
                   grade %in% input$gradeInput,
                   year >= input$yearInput[1],
                   year <= input$yearInput[2]
            )
    # Create chart
    ggplot(filtered, aes(x = loan_amnt, y = int_rate, color = loan_status, shape = loan_status)) +
      geom_point(size = 2) +
      theme_light() +
      xlim(0, 35000) +
      ylim(5, 25) +
      labs(x = "Loan Amount (US Dollars)", 
           y = "Interest Rate (%)", 
           color = "Loan Status", 
           shape = "Loan Status")
    
  })
  
})
