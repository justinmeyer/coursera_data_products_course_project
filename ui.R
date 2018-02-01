# ui.R

library(shiny)

# Define UI
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Lending Club Data Explorer"),
  fluidRow("Use the filters below to explore Lending Club peer-to-peer loan data. Be patient, the chart takes time to load."),
  # Sidebar with inputs
  sidebarLayout(
    sidebarPanel(
            sliderInput("amountInput", "Loan Amount", min = 0, max = 35000,
                        value = c(0, 35000)),
            sliderInput("installmentInput", "Installment Amount", min = 0, max = 1500,
                        value = c(0, 1500)),
            sliderInput("dtiInput", "Debt to Income Ratio", min = 0, max = 30,
                        value = c(0, 30)),
            checkboxGroupInput("gradeInput", "Grade",
                               c("A" = "A",
                                 "B" = "B",
                                 "C" = "C",
                                 "D" = "D",
                                 "E" = "E",
                                 "F" = "F",
                                 "G" = "G"),
                               selected = c("A", "B", "C", "D", "E", "F", "G")),
            sliderInput("yearInput", "Year", min = 2007, max = 2011,
                        value = c(2007, 2011))
            
    ),
    
    # Show plot
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
