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
shinyServer(
  function(input, output) {
    #filteredData1 <- reactive(load("../../data/lasso.RData"))
    #filteredData2 <- reactive(load("../../data/ols.RData"))
    #filteredData3 <- reactive(laod("../../data/plsr.RData"))
    #filteredData4 <- reactive(load("../../data/randomforest.RData"))
    output$title = renderUI({
      h3(input$model, align="center")
    })
    
    output$image = renderUI({
      selected <- input$model
      if (selected == "lasso") {
        imageName <- "lasso.png"
      } else if (selected == "ols") {
        imageName <- "ols.png" 
      } else if (selected == "plsr") {
        imageName <- "plsr.png"
      } else {
        imageName <- "randomforest.png"
      }
      tags$img(src=imageName, height=500, width=500)
    })
  
    output$table = renderTable({
      selected <- input$model
      if (selected == "lasso") {
        captions = "Lasso Coefficients"
        library(glmnet)
        edu = read.csv('../../data/final.csv', stringsAsFactors = FALSE)
        edu = edu[, -c(1)]
        
        grid = 10^seq(10, -2, length=100)
        
        set.seed(159)
        lasso = cv.glmnet(as.matrix(edu[,c(1:32)]), as.matrix(edu[,33]), intercept = FALSE, standardize = FALSE, lambda = grid, alpha = 1)
        
        lasso_best <- lasso$glmnet.fit$beta[,which(lasso$lambda == lasso$lambda.min)]
        lasso_best <- data.frame('variable' = names(lasso_best), 'coefficient' = lasso_best)
        rownames(lasso_best) <- c()
        library(xtable)
        xtable(lasso_best, caption = "Lasso Coefficients")
      } else if (selected == "ols") {
        captions = "OLS Significant Coefficients"
        load('../../data/ols.RData')
        ols_coef <- data.frame(summary(ols)$coefficients)
        ols_coef <- ols_coef[ols_coef$Pr...t.. <= .05,]
        ols_summary <- summary(ols)
        ols_mse <- ols_summary$sigma
        library(xtable)
        xtable(ols_coef[,c(1,4)], caption = "OLS Significant Coefficients")
      } else if (selected == "plsr") {
        captions = "PLSR Coefficients"
        load('../../data/plsr.RData')
        plsr_coef <- plsr$coefficients[,1,which.min(plsr$validation$PRESS)]
        plsr_coef <- data.frame('variable' = names(plsr_coef),'coefficient' = plsr_coef)
        rownames(plsr_coef) <- c()
        library(xtable)
        xtable(plsr_coef, caption = "PLSR Coefficients")
      } else {
        captions = "Relevant Variables from Random Forest"
        library(randomForest)
        load('../../data/randomforest.RData')
        rf_importance <- importance(model.rf$finalModel)
        rf_importance <- data.frame('variable' = rownames(rf_importance), 'IncNodePurity' = rf_importance)
        rownames(rf_importance) <- c()
        library(xtable)
        xtable(rf_importance[rf_importance$IncNodePurity > 4,], caption = "Relevant Variables from Random Forest")
      }
    }, caption = "Coefficients", caption.placement = getOption("xtable.caption.placement", "top"),
    caption.width = getOption("xtable.caption.width", NULL), rownames = TRUE, align = 'c')
    
    output$summary = renderUI({
      selected <- input$model
      if (selected == "lasso") {
        summary = "The coefficients of the lasso regression model. The highest is the number of Asian undergraduates 
        and the lowest is the number of students receiving a Pell grant."
      } else if (selected == "ols") {
        summary = "From these results we can see that the primary predictors of earning are SAT and ACT scores. Other
        significant variables are tuition, annual cost of attendance, the average net price of attendance, the number 
        of undergraduates, dependence, the borrowing rate, and reception of a Pell grant."
      } else if (selected == "plsr") {
        summary = "The coefficients of the PLSR model with the lowest lambda value. Of particular note are the number 
        of Asian undergraduates (the highest value) and the number of students receiving a Pell grant (the lowest value)."
      } else {
        summary = "The variables with a higher IncNodePurity value were the significant ones, which had more of an effect 
        predicting the earnings of a student. These variables are tuition, race (being white or Asian), and receiving a 
        loan in college."
      }
      h3(summary)
      })
  })
  
