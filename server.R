# Author : Peramanathan Sathyamoorthy

#setwd("~/Development/DemoClouding")
# Loading the tidy data: sqlite3 file
library("RSQLite")

drv <- dbDriver("SQLite")
# Active connection
con <- dbConnect(drv,"Active2mins.db")
mobileData <- dbGetQuery(con, "Select * from statistics")
deviceInfo <- dbGetQuery(con, "Select * from device_info")
#appStatsData <<- dbGetQuery(con, "Select name as NAME , cpu_usage_total as CPU , other_bytes_sent as SENT_DATA , other_bytes_received as RECEIVED_DATA from application_statistics order by cpu_usage_total desc")
#dbDisconnect(con)

# Idle connection
conIdle <- dbConnect(drv, "Idle10mins.db")
#idleData <<- dbGetQuery(conIdle, "Select name as NAME , cpu_usage_total as CPU , other_bytes_sent as SENT_DATA , other_bytes_received as RECEIVED_DATA from application_statistics order by cpu_usage_total desc")
#dbDisconnect(conIdle)
# Showing list of tables and fields respectively
# dbListTables(con) 
# dbListFields(con,"android_metadata")
#dbListFields(con,"statistics")
#View(mobileData)


menu <- function(x) {
  
  ifelse (x == "1", "Platform Active", ifelse(x == "2","Platform Idle", ifelse(x=="3", "Application Active","Application Idle")))
}

levelTable <- function(data){
  con <- dbConnect(drv,"Active2mins.db")
  if(data == "1"){
    
    statsData <- dbGetQuery(con, "Select name as NAME , cpu_usage_total as CPU , other_bytes_sent as SENT_DATA , other_bytes_received as RECEIVED_DATA from application_statistics order by cpu_usage_total desc")
    #dbDisconnect(con)
  }
  else if(data == "2"){
    
    statsData <- dbGetQuery(conIdle, "Select name as NAME , cpu_usage_total as CPU , other_bytes_sent as SENT_DATA , other_bytes_received as RECEIVED_DATA from application_statistics order by cpu_usage_total desc")
    #dbDisconnect(conIdle)    
  }
  else if (data == "3"){ # messenger app for demo
    activeMessengerId <- dbGetQuery(con, "Select _id from application_statistics where name ='Messenger' ")
    #appDataBase <- paste("application_sensor_",messengerId[[1]],sep = "")
    query <- paste("Select timestamp, cpu_usage, other_bytes_sent, other_bytes_received from application_sensor_",activeMessengerId[[1]],sep = "")
    statsData <- dbGetQuery(con, query)
  }
  else{
    idleMessengerId <- dbGetQuery(conIdle, "Select _id from application_statistics where name ='Messenger' ")
    #appDataBase <- paste("application_sensor_",messengerId[[1]],sep = "")
    query <- paste("Select timestamp, cpu_usage, other_bytes_sent, other_bytes_received from application_sensor_",idleMessengerId[[1]],sep = "")
    statsData <- dbGetQuery(conIdle, query)    
  }
  statsData
}

shinyServer(
  function(input, output){
    output$olevel <- renderPrint({menu(input$level)})
    output$oDeviceInfo <- renderPrint(deviceInfo)
    output$platformTable <- renderPrint(levelTable(input$level))
  }
  
)