
sideBarStepsUI <- function(id){
  ns <- NS(id)
  tagList(
    #verbatimTextOutput("debug"),
    column(4,
           div(id="sidebar",
               div(id="sidebar_step1",
                   div(id="sidebar_step1_title", class = "clickable",
                       h5("Data Input",
                          span(
                            hidden(img(src="triangle-closed.png",id="sidebar_step1_triangle-closed")),
                            img(src="triangle-open.png",id="sidebar_step1_triangle-open")
                          )
                       )
                   ),
                   div(id="sidebar_step1_contents", class = "clickable",
                       div(id = "dataControlsSection",
                           p("dataInput sidebar section")
                       )
                   )
               ),
               div(id="sidebar_step2",
                   div(id="sidebar_step2_title", class = "clickable",
                       h5("Visualize",
                          span(
                            img(src="triangle-closed.png",id="sidebar_step2_triangle-closed"),
                            hidden(img(src="triangle-open.png",id="sidebar_step2_triangle-open"))
                          )
                       )
                   ),
                   hidden(div(id="sidebar_step2_contents", class = "clickable",
                              p("visualize sidebar section")
                   ))
               ),
               div(id="sidebar_step3",
                   div(id="sidebar_step3_title", class = "clickable",
                       h5("Publish",
                          span(
                            img(src="triangle-closed.png",id="sidebar_step3_triangle-closed"),
                            hidden(img(src="triangle-open.png",id="sidebar_step3_triangle-open"))
                          )
                       )
                   ),
                   hidden(div(id="sidebar_step3_contents", class = "clickable",
                              p("publish sidebar section")
                   ))
               )
           )
    ),
    column(8,
           div(id = "main",
               div(id="main_step1",
                   div(id="dataSection",
                       p("dataInput main"),
                       br()
                   )

               ),
               hidden(div(id="main_step2",
                          actionLink("showDataPreview","Show Data"),
                          p("viz main")
               )),
               hidden(div(id="main_step3",
                          p("publish main")
               )
               )
           )
    )
  )
}

sideBarSteps <- function(input,output,session){
  availableSteps <- c("step1","step2", "step3")

  current <- reactiveValues(step = "step1")

  ## Observe

  observeEvent(current$step,{
    step <- current$step
    otherSteps <- availableSteps %>% keep(~ . != step)
    # Show current step - sidebar
    shinyjs::show(paste0("sidebar_",step,"_contents"),anim = TRUE, time = 0.1)
    shinyjs::hide(paste0("sidebar_",step,"_triangle-closed"))
    shinyjs::show(paste0("sidebar_",step,"_triangle-open"))
    # Hide all other steps - sidebar
    map(otherSteps,function(s){
      shinyjs::hide(paste0("sidebar_",s,"_contents"),anim = TRUE, time = 0.1)
      shinyjs::show(paste0("sidebar_",s,"_triangle-closed"))
      shinyjs::hide(paste0("sidebar_",s,"_triangle-open"))
    })
    # Hide all other steps - main
    map(availableSteps,function(s){
      shinyjs::hide(paste0("main_",s),anim = TRUE, time = 0.1)
    })
    # Show current step - main
    shinyjs::show(paste0("main_",step),anim = TRUE, time = 0.1)
  })

  observe({
    updateCurrentStepOnClick <- function(step){
      shinyjs::onclick(paste0("sidebar_",step,"_title"),{
        current$step <- step
      })
    }
    map(availableSteps,updateCurrentStepOnClick)
  })

}





