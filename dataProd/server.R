library(shiny)

appendRow <- function(existingDF, newrow) {
  existingDF <- rbind(existingDF[1:nrow(existingDF),],newrow)
}

korPopulation <- data.frame(region           = "Seoul",
                            population_2009  = 10104, density_2009     = 16694,
                            population_2010  = 10051, density_2010     = 16606,
                            population_2011  = 10026, density_2011     = 16567,
                            population_2012  = 9976,  density_2012     = 16484,
                            population_2013  = 9991,  density_2013     = 16509,
                            stringsAsFactors = FALSE)
row2  = c("Busan"    , 3488, 4553, 3466, 4517, 3464, 4509, 3445, 4476, 3430, 4456) 
row3  = c("Daegu"    , 2475, 2800, 2472, 2796, 2477, 2803, 2475, 2801, 2471, 2797)
row4  = c("Incheon"  , 2691, 2620, 2713, 2636, 2750, 2664, 2793, 2684, 2816, 2705) 
row5  = c("Gwangju"  , 1476, 2944, 1489, 2972, 1506, 3005, 1514, 3020, 1518, 3029) 
row6  = c("Daejeon"  , 1504, 2787, 1511, 2798, 1527, 2827, 1540, 2851, 1546, 2862)
row7  = c("Ulsan"    , 1094, 1034, 1094, 1033, 1105, 1043, 1116, 1053, 1120, 1057)
row8  = c("Gyeonggi" , 11376, 1122, 11576, 1139, 11788, 1159, 11937, 1173, 12081, 1188)
row9  = c("Gangwon"  , 1483, 89, 1487, 89, 1496, 89, 1503, 90, 1505, 89)
row10 = c("Chungbuk" , 1515, 204, 1522, 205, 1539, 207, 1551, 209, 1561, 211)
row11 = c("Chungnam" , 2039, 236, 2076, 241, 2104, 244, 2132, 246, 2148, 248)
row12 = c("Jeonbuk"  , 1791, 222, 1794, 222, 1802, 223, 1805, 224, 1803, 224)
row13 = c("Jeonnam"  , 1785, 146, 1777, 145, 1772, 145, 1768, 144, 1762, 143)
row14 = c("Gyeongbuk", 2632, 138, 2628, 138, 2638, 139, 2645, 139, 2642, 139)
row15 = c("Gyeongnam", 3185, 302, 3208, 305, 3232, 307, 3247, 308, 3263, 310) 
row16 = c("Jeju"     , 545, 295, 547, 296, 552, 299, 559, 302, 560, 303) 

korPopulation <- appendRow(korPopulation, row2)
korPopulation <- appendRow(korPopulation, row3)
korPopulation <- appendRow(korPopulation, row4)
korPopulation <- appendRow(korPopulation, row5)
korPopulation <- appendRow(korPopulation, row6)
korPopulation <- appendRow(korPopulation, row7)
korPopulation <- appendRow(korPopulation, row8)
korPopulation <- appendRow(korPopulation, row9)
korPopulation <- appendRow(korPopulation, row10)
korPopulation <- appendRow(korPopulation, row11)
korPopulation <- appendRow(korPopulation, row12)
korPopulation <- appendRow(korPopulation, row13)
korPopulation <- appendRow(korPopulation, row14)
korPopulation <- appendRow(korPopulation, row15)
korPopulation <- appendRow(korPopulation, row16)

shinyServer(
  function(input, output) {
    output$inputValue <- renderPrint({korPopulation[input$regionId, 1]})
    output$pred <- renderPrint({
      tempDF <- data.frame(year=c(2009, 2010, 2011, 2012, 2013),
                           population=c(as.numeric(korPopulation[input$regionId, 2]),
                                        as.numeric(korPopulation[input$regionId, 4]),
                                        as.numeric(korPopulation[input$regionId, 6]),
                                        as.numeric(korPopulation[input$regionId, 8]),
                                        as.numeric(korPopulation[input$regionId, 10])))
      lmfit <- lm(population~year, data=tempDF)
      as.numeric(predict(lmfit, newdata=data.frame(year=2014, population=0)))
    })
    output$plot <- renderPlot({
      plot(x=c(2009, 2010, 2011, 2012, 2013),
           y=korPopulation[input$regionId, c(2, 4, 6, 8, 10)],
           xlab="Year", ylab="Population (thousand)",
           main=korPopulation[input$regionId, 1], pch=19)
      lines(x=c(2009, 2010, 2011, 2012, 2013),
            y=korPopulation[input$regionId, c(2, 4, 6, 8, 10)])
    })    
})
