
library(shiny)

# Loading data
nhanes <- read.csv('~/data/nhanes_data.csv')

# k-means only works with numerical variables, eliminating categorical variables
vars <- setdiff(names(nhanes), "SEQN")

pageWithSidebar(
  headerPanel('K-means clustering of NHANES 2017-2020 data'),
  sidebarPanel(
    selectInput('xcol', 'X Variable', vars, selected = vars[[6]]),
    selectInput('ycol', 'Y Variable', vars, selected = vars[[3]]),
    sliderInput('clusters', 'Cluster count', 3, min = 1, max = 9, step = 1),
    helpText(a("Please use the slider to select the number of clusters")),
    helpText("\n Use the average silhouette graph on the right as a guide in determining the ideal cluster sizes.
              A high average silhouette width indicates good clustering.")
    
  ),
  
  mainPanel(
    plotOutput('plot1'), plotOutput('plot2')
  )
)
