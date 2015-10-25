library(shiny)

#load ggplot and manipulate mtcars for plotting
init = function(){
    library(ggplot2)
    mtcars$Cylinder = factor(mtcars$cyl, levels = c(4, 6, 8), labels = c("4 Cylinder", "6 Cylinder", "8 Cylinder"))
    mtcars
}

#fit a generalize lineral model for transmission
am.glm = function(){
    glm(am ~ hp + wt, data=mtcars, family=binomial)
}

#fit a linear model for mpg
mpg.lm = function(){
    lm(mpg ~ hp + wt + cyl, data=mtcars)
}

shinyServer(function(input, output) {
    mtcars = init()
    
    output$input.hp = renderText({input$hp})
    output$input.wt = renderText({input$wt})
    output$input.cyl = renderText({input$cyl})
    
    output$am.prediction = renderText({
        input.df = data.frame(hp=input$hp, wt=input$wt/1000)
        am.prediction = predict(am.glm(), input.df, type="response")
        paste0(format(am.prediction*100, trim=TRUE, digits=4), '%')
    })
    
    output$mpg.prediction = renderText({
        input.df = data.frame(hp=input$hp, wt=input$wt/1000, cyl=input$cyl)
        mpg.prediction = predict(mpg.lm(), input.df)
        paste0(format(mpg.prediction, trim=TRUE, digits=3), 'mpg')
    })
    
    output$plot = renderPlot({
        ggplot(mtcars, aes(x=mpg, y=hp, color=Cylinder)) + geom_line(size=1) +
        xlab("Miles Per Gallon") + ylab("Horsepower") + ggtitle("Miles Per Gallon to Horsepower") +
        theme(panel.background = element_rect(fill="white"))
    })
  
})
