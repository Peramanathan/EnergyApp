# Author : Peramanathan Sathyamoorthy
# User Display

library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("BatBoomer Energy Analyser"),
  sidebarPanel(
    radioButtons('level','Choose the level',
                 c("Platform Active"="1",
                   "Platform Idle"="2",
                   "Messenger Active"="3",
                   "Messenger Idle"="4")),
    textInput("app", "Type App Name", "")
    #submitButton("submit")
    
  ),
  
  mainPanel(
    h3('Analysed Results for'),
    verbatimTextOutput("olevel"),
    verbatimTextOutput("oDeviceInfo"),
    verbatimTextOutput("platformTable")
  )

))