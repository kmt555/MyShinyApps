library(shiny)

ui <- fluidPage(
 
  sidebarLayout(
    
    sidebarPanel(
      
      sliderInput(inputId = "n",
                  label = "No. of coin flips", min = 10, max = 1000, value = 10),
      
      sliderInput(inputId = "prob",
                  label = "Success of rate", min = 0, max = 1, value = 0.5)
      
    ), 
   
    
     mainPanel( plotOutput(outputId = "xxxxx"),
                plotOutput(outputId = "aaa"),
                plotOutput(outputId = "ccccc")
                
                
                )
                  )
  
   
)

server <- function(input, output, session) {
  
  something <- reactive(table(rbinom(n=input$n, size = 1, prob = input$prob)))
                   
  output$xxxxx <- renderPlot({   
  
                     barplot(something())   
     
})
  
  output$aaa <- renderPlot({   
    
    barplot(something())   
    
  })
  
  
  output$ccccc <- renderPlot({   
    
    barplot(table(rbinom(n=input$n, size = 1, prob = input$prob)))   
    
  })
  
}

shinyApp(ui, server)