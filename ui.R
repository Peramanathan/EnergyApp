# ---------------------------
# Author: Peramanathan Sathyamoorthy
# ---------------------------

library(shiny)
library(markdown)

shinyUI(
        fluidPage(                
                # Global Page Style Settings
                style = "padding-top: 10px; padding-bottom: 50px; font-family: arial;",
                
                # Menu Bar
                navbarPage(
                        
                        title = h4("EnergyApp: Log Analyzer and Data Visulizer"),
                        position = "static-top",
                        
                        # Menu-0
                        tabPanel("Load Data",
                                 fileInput('file1', 'Load Trepn Profiler Log file',
                                           accept=c('.db')),
                                 p(strong(h5("Data Status"))),
                                 verbatimTextOutput("isLoaded"),
                                 p(strong(h5("Device Information"))),
                                 verbatimTextOutput("deviceInfo"),                                 
                                 p(strong(h5("Available Tables"))),
                                 verbatimTextOutput("tables")
                        ),
                        
                        # Menu-1
                        tabPanel("Manual Inspector",  
                                 h1("Displaying Application Statistics Table"),
                                 dataTableOutput("contents")                                 
                        ),
                        
                        # Menu-2
                        tabPanel("Plots", 
                                 pageWithSidebar(
                                         headerPanel(""),
                                         sidebarPanel(
                                                 h1("Options"),
                                                 selectInput("datatables", "Data Set", choices = "statsData"),
                                                 uiOutput("xaxisui"),
                                                 uiOutput("yaxisui"),
                                                 uiOutput("colorbyui"),
                                                 radioButtons("plottype", 
                                                              label = ("Select Plot Type"),
                                                              choices = list(
                                                                      "Line" = "line",
                                                                      "Point" = "point"
                                                              ),
                                                              selected = "point"
                                                 ),
                                                 actionButton("goButton", "Generate Plot")
                                         ),
                                         mainPanel(
                                                 h1("Generic Plot for data table"),
                                                 em(h5("compare 3 parameters")),
                                                 plotOutput("genericplot", width = 800, height = 600)
                                         )
                                 )
                        ),
                        
                        # Menu-5
                        navbarMenu("Help",
                                   tabPanel("Data Collection",
                                            p(h1("Trepn Profiler Log file")),
                                            p(strong(h5("Description"))),
                                            helpText(
                                              "The data(logs) can collected by using either Trepn Plugin for Eclipse or Trepn Mobile App "
                                            ),
                                            
                                            p(strong(h5("Usage"))),
                                            helpText(
                                              "Profile either whole platform or targeted application", br(),
                                              "It will produce sqlite3 format .db files which contains number of tables", br(),
                                              "Just load the log file using EnergyApp's Load Data menu ", br(),
                                              "Now you can visulize and manually play with the data"
                                            )                                         
                                            
                                   ),
                                   tabPanel("App Documentation",
                                            navlistPanel(
                                              "Tabel of Contents",
                                              tabPanel("EnegyApp - 1.0",
                                                       h3("EnergyApp Analytics and Visualizer"),
                                                       p("This application is developed for the master thesis titled ", strong("Enabling Energy Efficiency Data Communication with Participatory Sensing and Mobile Cloud")),
                                                       br()
                                              ),                                                    
                                              tabPanel("Load Data",
                                                       h3("For the data preparation refer : Data Collection"),
                                                       p("This is first step to start using this service"),
                                                       p("Once the data successfully loaded you will get some useful metainfo")                                                                                                                          
                                              ),
                                              tabPanel("Manual Inspection",
                                                       h3("Inspection of data tables"),
                                                       p("Currently apllication statistics table only viewed and "),
                                                       p("Loading other tables will be supported")                                                             
                                              ),
                                              tabPanel("Plot",
                                                       h3("Plot"),
                                                       p("User can generate a Plot based on any 3 column data"),                                                             
                                                       p("User can choose between a Line or Point Plot"),
                                                       p("On click of 'Generate Plot' button the Plot will be generated")
                                              )        
                                             
                                              
                                            )
                                   )
                        )
                        
                ),# Menu bar   
                        
                       
                # Footer with Data & Time Stamp
                absolutePanel(
                        bottom = 0, 
                        left = 0, 
                        right = 0,
                        fixed = TRUE,
                        div(
                                style="padding: 8px; background: #575757; position:relative; z-index:10; text-align:right; color:white;",
                                textOutput("currentTime")
                        )
                )
               
        )# end of fluidPage
) # end of shinyUI
