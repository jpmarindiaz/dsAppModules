
## Data upload module


styles <- "
.clickable{
cursor: pointer;
}

"
ui <- fluidPage(
  useShinyjs(),
  verbatimTextOutput("debug"),
  sideBarStepsUI("layout"),
  inlineCSS(styles)
)

server <- function(input,output,session){
  current <- callModule(sideBarSteps, "layout")
  output$debug <- renderPrint({
    #current()
  })

  # availableSteps <- c("step1","step2", "step3")
  #
  # current <- reactiveValues(step = "step1")
  #
  # ## Observe
  #
  # observeEvent(current$step,{
  #   step <- current$step
  #   otherSteps <- availableSteps %>% keep(~ . != step)
  #   # Show current step - sidebar
  #   shinyjs::show(paste0("sidebar_",step,"_contents"),anim = TRUE, time = 0.1)
  #   shinyjs::hide(paste0("sidebar_",step,"_triangle-closed"))
  #   shinyjs::show(paste0("sidebar_",step,"_triangle-open"))
  #   # Hide all other steps - sidebar
  #   map(otherSteps,function(s){
  #     shinyjs::hide(paste0("sidebar_",s,"_contents"),anim = TRUE, time = 0.1)
  #     shinyjs::show(paste0("sidebar_",s,"_triangle-closed"))
  #     shinyjs::hide(paste0("sidebar_",s,"_triangle-open"))
  #   })
  #   # Hide all other steps - main
  #   map(availableSteps,function(s){
  #     shinyjs::hide(paste0("main_",s),anim = TRUE, time = 0.1)
  #   })
  #   # Show current step - main
  #   shinyjs::show(paste0("main_",step),anim = TRUE, time = 0.1)
  # })
  #
  # observe({
  #   updateCurrentStepOnClick <- function(step){
  #     shinyjs::onclick(paste0("sidebar_",step,"_title"),{
  #       current$step <- step
  #     })
  #   }
  #   map(availableSteps,updateCurrentStepOnClick)
  # })


}
shinyApp(ui,server)





