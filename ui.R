library(shiny)

shinyUI(fluidPage(
  titlePanel("BatBoomer Energy Analyser"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Load Trepn Profiler log file .db',
                accept=c('.db'))
      
    ),
    mainPanel(
      tableOutput('contents')
    )
  )
))