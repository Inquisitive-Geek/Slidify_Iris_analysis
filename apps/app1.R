library(shiny)
library(glmnet)
data(iris)
cv.fit <- cv.glmnet(as.matrix(iris[,-5]), 
                    iris[,5], alpha=0.8, 
                    family="multinomial")
irisSpecies <- function(input) {
  Sepal.Length <- as.numeric(input$Sepal.Length)
  Sepal.Width <- as.numeric(input$Sepal.Width)
  Petal.Length <- as.numeric(input$Petal.Length)
  Petal.Width <- as.numeric(input$Petal.Width)
  test <- data.frame(Sepal.Length,Sepal.Width,Petal.Length,Petal.Width)
  species <- predict(cv.fit, 
                     newx=as.matrix(test),
                     type="class")
  return(species)
}

  output$sepalLen <- renderPrint({input$Sepal.Length})
  output$sepalWid <- renderPrint({input$Sepal.Width})
  output$petalLen <- renderPrint({input$Petal.Length})
  output$petalWid <- renderPrint({input$Petal.Width})
  output$Species <- renderPrint({irisSpecies(input)})
 