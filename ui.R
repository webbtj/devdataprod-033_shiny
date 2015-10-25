library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Engine Prediction"),
  
  sidebarPanel(
    sliderInput("hp", "Horsepower", min = 50, max = 380, step = 5, value = 110),
    
    sliderInput("wt", "Weight (lbs)", min = 1100, max = 5800, step = 100, value = 2200),
    
    sliderInput("cyl", "Cylinders", min = 4, max = 8, step = 2, value = 6)
  ),
  
    mainPanel(
        tabsetPanel(
            tabPanel("Predictions",
                #Inputs
                h4('You entered the following horsepower'),
                verbatimTextOutput("input.hp"),
                
                h4('You entered the following weight (lbs)'),
                verbatimTextOutput("input.wt"),
                
                h4('You entered the following number of cylinders'),
                verbatimTextOutput("input.cyl"),
                
                #Outputs
                h4('We\'ve predicted the following likelihood that this is a manual transmission'),
                verbatimTextOutput("am.prediction"),
                
                h4('We\'ve also predicted the following fuel economy (miles per gallon)'),
                verbatimTextOutput("mpg.prediction")
            ),
            tabPanel("Plot",
                h4("Reference Plot"),
                p("For reference, a plot of miles per gallon compared to horsepower is provided, coloured by number of cylinders."),
                plotOutput("plot")
            ),
            tabPanel("Documentation",
                h4("Documentation"),
                p("This app uses the mtcars sample dataset included with RStudio to make predictions about the transmission and fuel economy of a vehicle."),
                p("Use the sliders to the left to adjust the horsepower, weight (in lbs), and number of cylinders of a vehicle."),
                p("The app will fit a generalized linear model using the horsepower and weight to predict the likelihood of a manual transmission."),
                p("The app will fit a lineral model using the horsepower, weight, and cylinders to predict fuel economy.")
            ),
            tabPanel("About",
                h4("About"),
                p("Built by TJ Webb using Shiny and RStudio for the Coursera course Developing Data Products from Johns Hopkins, part of the Signature Track of the Data Science Specialization. Instructed by Brian Caffo, PhD, Jeff Leek, PhD, and Roger Peng, PhD. "),
                h4("Disclaimer"),
                p("There is nothing about this application that should be consider accurate with actual vehicles. The lineral models are fit with a very small dataset."),
                p("Additionally, I know nothing about vehicles and while these three parameters definitely have a significant impact of the variables they are trying to predict, there are many other factors not accounted for here which will lead to inaccuarte results (though the results should be considered accurrate winthin the context of the sample data and the nature of this demo).")
            )
        )
    )
))
