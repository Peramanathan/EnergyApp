# Author : Peramanathan Sathyamoorthy
# User Display

library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("BatBoomer Energy Analyser"),
  sidebarPanel(
    radioButtons('level','Choose the level',
                 c("Platform Active"="1",
                   "Platform Idle"="2",
                   "Application Active"="3",
                   "Application Idle"="4"))
  ),
  
  mainPanel(
    h3('Analysed Results for'),
    verbatimTextOutput("olevel"),
    verbatimTextOutput("oDeviceInfo"),
    verbatimTextOutput("platformTable")
  )

))