#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

library(RColorBrewer)





library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel(title = "Stat159-final report"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("model", "select prediction", c("lasso", "plsr", "ols", "randomForest"))
    ),
  
      
      
     # Show a plot of the generated distribution
    mainPanel(
      uiOutput("title"),
      uiOutput("image"),
      uiOutput("table"),
      uiOutput("summary")
    )
  )
))

