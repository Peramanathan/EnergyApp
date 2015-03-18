library(shiny)

shinyUI(fluidPage(
  titlePanel("BatBoomer Energy Analyser"),
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Load Trepn Profiler log file .db',
                accept=c('.db')),
      p("Treph profiler can be dowloaded from here"),
      a(href='https://developer.qualcomm.com/mobile-development/increase-app-performance/trepn-plug-eclipse/trepn-plug-eclipse-getting-started','Trepn for Eclipse')
      
    ),
    mainPanel(
      tableOutput('contents')
    )
  )
))