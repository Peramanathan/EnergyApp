# ---------------------------
# Author: Peramanathan Sathyamoorthy
# ---------------------------

library(shiny)
library(ggplot2)
library("RSQLite")
source("helper.R")

data <- NULL
statsData <<- NULL
dataNames <<- NULL

shinyServer(function(input, output, session) {
        
        drv <- dbDriver("SQLite")
        con <- NULL
        devInfo <- NULL
        tbls <- NULL
        
        # Read input data and cache it 
        dataBulk <- reactive({
          
          inFile <- input$file1
          
          if (is.null(inFile))
            return(NULL)              
          
          con <<- dbConnect(drv,inFile$datapath)
          tbls <<- dbListTables(con)
          output$tables <<- renderPrint(tbls)
          output$deviceInfo <<- renderPrint(dbGetQuery(con, "Select * from device_info"))          
          
          statsData <<- dbGetQuery(con, "Select * from application_statistics")
          #dataTableOutput("contents")
          
          
          d <- makeCacheData(statsData)
          data <- cacheData(d)     
          dataNames <<- names(data)
          data
          
        })      
        
        
        # loading data and keep the data saved for further process
        output$isLoaded <- renderPrint({          
          statsData <- dataBulk()          
          ifelse(!is.null(statsData),"The file is successfuly loaded","Data not loaded yet !")           
        })        
        
        output$contents <- renderDataTable({
          statsData <- dataBulk()         
          statsData
        })        
        
              
        # Dynamically create UI input selects
        output$xaxisui <- renderUI({
          selectInput("xaxis", "X - Axis",choices = dataNames, selected = dataNames[5])
        })        
        output$yaxisui <- renderUI({
          selectInput("yaxis", "Y - Axis",choices = dataNames, selected = dataNames[8])
        })
        output$colorbyui <- renderUI({
          selectInput("colorby", "Color By",choices = dataNames, selected = dataNames[3])
        })
        
          
        output$genericplot <- renderPlot({
          # Take a dependency on input$goButton
          statsData <- dataBulk()
          
          input$goButton                     
          # Use isolate() to avoid dependency on oter input$s
          
          genplot <- ggplot(statsData, aes_string(input$xaxis, input$yaxis, color = input$colorby)) + layer(geom = input$plottype)
                  
          print(genplot)
                       
        })        
        
        output$currentTime <- renderText({
                invalidateLater(1000, session)
                paste("", Sys.time())
        })
})

# Appendix
# statsData <<- dbGetQuery(con, "Select name as NAME , cpu_usage_total as CPU ,
# other_bytes_sent as SENT_DATA , other_bytes_received as RECEIVED_DATA from application_statistics order by cpu_usage_total desc")
# Change values for input$inSelect

# isolate({
#          genplot <- ggplot(statsData, aes_string(input$xaxis, input$yaxis, colour= input$colorby)) + layer(geom = input$plottype)
#         print(genplot)
#})  
