library(shiny) 

library(dplyr)
library(tibble)
library(stringr)
library(ggplot2)

# Example from: https://www.r-bloggers.com/2019/12/r-shiny-for-beginners-annotated-starter-code/

# Define UI
ui <- fluidPage(titlePanel("Heads or Tails"),
                sidebarLayout(
                  sidebarPanel(
                    sliderInput(inputId = "n", label = "No. of flips:", min = 10, max = 1000, value = 500),
                    sliderInput(inputId = "prob", label = "Success rate:", min = 0, max = 1, value = 0.5)
                  ), 
                  mainPanel(plotOutput(outputId = "bars"))
                )
                )

# Define server logic ----

server <- function(input, output) {
  
  output$bars <- renderPlot({
    #barplot(table(rbinom(n = input$n,size = 1,prob = input$prob)))
   
    # most of this is for ggplot2; note the input$x syntax
    flips <- tibble(flips = rbinom(input$n, 1, input$prob)) %>%
      mutate(flips = if_else(flips == 1, "Heads", "Tails"))
    flips %>%
      count(flips) %>%
      ggplot(aes(flips, n, fill = flips)) +
      geom_col() +
      geom_label(aes(flips, n, label = n), size = 5) +
      theme(legend.position = "none",
            axis.text = element_text(size = 15)) +
      labs(x = "", y = "") +
      ggtitle(str_c("Results of ", input$n,
                    " flips with Heads probability ",
                    sprintf("%.2f", input$prob)))
     
  }
  )
 
}

# Run the app ----
shinyApp(ui = ui, server = server)


