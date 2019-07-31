
library(plotly)
library(jsonlite)
library(dplyr)
library(readxl)

# Read data
cruise<- read_excel("C:/Users/gregs/Documents/DS Projects.xlsx", 
                    sheet = "Tom Cruise")
attach(cruise)
cruise<-cruise[order(-Distance),]
detach(cruise)

# cruise <- as.data.frame(cruise, stringsAsFactors = F)
p <- list()

# Set line widths
innerwidth <- 10
outerwidth <- 25

for(i in 1:nrow(cruise)){
  
  attach(cruise[i,])
  
  p[[i]] <-
    
    # Box Office
    plot_ly() %>%
    add_segments(x = 0,
                 xend = as.numeric(Box_Office),
                 y = Movie,
                 yend = Movie,
                 # name = "Box Office",
                 # mode = 'text',
                 # text = ~Box_Office,
                 # textposition=as.numeric(Box_office),
                 # hoverinfo = "x",
                 line = list(color = "#eeeeee", width = outerwidth)) %>%

    # Distance Run
    add_segments(x = 0,
                 xend = as.numeric(Distance),
                 y = Movie,
                 yend = Movie,
                name = "Distance",
                mode = 'text',
                text = ~Distance,
                textposition = 'auto',
                hoverinfo = "x",
                line = list(color = "#b0c4de", width = innerwidth)) %>%
    
     layout(showlegend = F,
           title="Run, Tom, Run!",
           xaxis = list(Movie = "", showgrid = F, 
                        range = c(0, 7000),
                        
                        showticklabels = FALSE,
                        showline = FALSE,
                        ticklen = 0,
                        tickfont = list(family = "Arial", size = 10),
                        tickcolor = "#cccccc") 
           
     %>%

   add_annotations(
                  x = 0,  y = Movie,
                  text = Distance,
                  font = list(family = 'Arial', size = 12,
                              color = 'rgb(50, 171, 96)'),
                  showarrow = FALSE)
     )

  detach(cruise[i,])
}

pp <- subplot(p[[1]], p[[2]], p[[3]], p[[4]], 
              p[[5]], p[[6]], p[[7]], p[[8]],
              p[[9]], p[[10]],p[[11]],p[[12]],
              p[[13]], p[[14]], p[[15]],
              p[[16]],
              nrows = 17,
              margin = c(0, 0, 0,0))

pp
