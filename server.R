
# Loading data
nhanes <- read.csv('~/data/nhanes_data.csv')

library(shiny)
library(factoextra)
shinyServer(
  function(input, output) {
  
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    nhanes[, c(input$xcol, input$ycol)]
  })
  
  clusters <- reactive({
    kmeans(selectedData(), input$clusters, nstart = 25)
  })

  output$plot1 <- renderPlot({
    palette(c("#E41A1C", "#3333FF", "#4DAF4A", "#984EA3",
              "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
    
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 0.5)
    points(clusters()$centers, pch = 8, cex = 1.5, lwd = 4)
    })
  output$plot2 <- renderPlot({

     fviz_nbclust(selectedData(), kmeans, method = "silhouette")
  })
  }
)
