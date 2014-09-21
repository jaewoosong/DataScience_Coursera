library(shiny)
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Population & Population Density of South Korea"),
    sidebarPanel(
      radioButtons(inputId="regionId", label="Region",
                   choices=c("Seoul"     = "1",  "Busan"     = "2",
                             "Daegu"     = "3",  "Incheon"   = "4",
                             "Gwangju"   = "5",  "Daejeon"   = "6",
                             "Ulsan"     = "7",  "Gyeonggi"  = "8",
                             "Gangwon"   = "9",  "Chungbuk"  = "10",
                             "Chungnam"  = "11", "Jeonbuk"   = "12",
                             "Jeonnam"   = "13", "Gyeongbuk" = "14",
                             "Gyeongnam" = "15", "Jeju"      = "16"))
    ),
    mainPanel(
      h2('You chose'),
      verbatimTextOutput("inputValue"),
      h2('By linear regression, in 2014 the population will be (thousands)'),
      verbatimTextOutput("pred"),
      h2('Its population and population density graph'),
      plotOutput("plot")
    )
  )
)
