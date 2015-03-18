library("RSQLite")


shinyServer(function(input, output){

    
    
    #inFile <- reactive({})

    
      
    #output$olevel <- renderPrint({menu(input$level)})
    #output$oDeviceInfo <- renderPrint(deviceInfo)
    output$platformTable <- renderTable({
      inFile <- input$file1
      
      if (!is.null(inFile)){
        drv <- dbDriver("SQLite")
        con <- dbConnect(drv,inFile$datapath)
        statsData <- dbGetQuery(con, "Select name as NAME , cpu_usage_total as CPU , other_bytes_sent as SENT_DATA , other_bytes_received as RECEIVED_DATA from application_statistics order by cpu_usage_total desc")
        #output$platformTable <- renderPrint(statsData)
      }
    })
    
    
    #output$plot <- renderPlot({ hist(input$file[ , 1]) })
  }
  
)