library(shiny)
library("RSQLite")

shinyServer(function(input, output) {
  output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    
    drv <- dbDriver("SQLite")
    con <- dbConnect(drv,inFile$datapath)
    statsData <- dbGetQuery(con, "Select name as NAME , cpu_usage_total as CPU , other_bytes_sent as SENT_DATA , other_bytes_received as RECEIVED_DATA from application_statistics order by cpu_usage_total desc")
    
    #read.csv(inFile$datapath, header=input$header, sep=input$sep,quote=input$quote)
  })
})