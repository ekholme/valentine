

# Setup -------------------------------------------------------------------

library(tidyverse)
library(shiny)
library(glue)

#puns
puns <- readxl::read_excel(here::here("Data/puns.xlsx"), col_names = FALSE) %>%
  pull()

#froms
froms <- c("Eric", "Emma", "Nala")

#get random pun
get_pun <- function() {
  tmp <- sample(puns, size = 1)
  
  glue("{ tmp }")
}

#get random from
get_from <- function() {
  tmp <- sample(froms, size = 1)
  
  glue("Love { tmp }")
}


# UI ----------------------------------------------------------------------

ui <- fluidPage(
  
  #styling
  tags$head(
    
    tags$style(
      
      HTML("
      @import url('https://fonts.googleapis.com/css2?family=Lobster');
      
      .button {
        align: center;
      }
      
      .text {
        font-family: 'Lobster';
        font-style: bold;
      }
      
      #title {
         color: red;
         font-style: bold;
         font-family: 'Lobster', sans-serif;
         text-align: center;
         }
           ")
      
    )
  ),
  
  h1(id = "title", "Ken Valentine Generator"),
  
  actionButton("generate", "Get a Valentine!", class = "button"),
  
  br(),
  
  p("Dear Ken,", class = "text"),
  
  br(),
  
  textOutput("pun") %>% tagAppendAttributes(class = "text"),
  
  br(),
  
  textOutput("from") %>% tagAppendAttributes(class = "text")
  
  #sidebarLayout(
  #  sidebarPanel(
  #    width = 3,
  #    actionButton("generate", "Get a Valentine!")
  #  ),
    
  #  mainPanel(
  #    width = 9,
      
  #    p("Dear Ken,"),
      
  #    br(),
      
  #    textOutput("pun"),
      
  #    br(),
      
  #    textOutput("from")
  #  )
  #)
  
)



# Server ------------------------------------------------------------------

server <- function(input, output, session) {
  
  pun_samp <- eventReactive(input$generate, {
    get_pun()
  })
  
  from_samp <- eventReactive(input$generate, {
    get_from()
  })
  
  output$pun <- renderText({pun_samp()})
  
  output$from <- renderText({from_samp()})
}


# Run App -----------------------------------------------------------------

shinyApp(ui = ui, server = server)
