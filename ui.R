shinyUI(dashboardPage(skin = "black",
                      
                      dashboardHeader(title = 'Suicidio',
                                      tags$li(a(onclick = "onclick = window.open('https://www.linkedin.com/in/eduardo-bacigalupe-nunes-43271719b/')",
                                                href = NULL,
                                                icon("linkedin"),
                                                title = "LinkedIn",
                                                style = "cursor: pointer;"),
                                              class = "dropdown")),
                      
                      dashboardSidebar(
                          sidebarMenu(
                              menuItem('Sobre el Suicidio', tabName = 'intro', icon = icon('book-open')),
                              menuItem('Países', tabName = 'pais', icon = icon('globe-europe')),
                              menuItem('Género', tabName = 'genero', icon = icon('venus-mars')),
                              menuItem('Edad', tabName = 'edad', icon = icon('address-card')),
                              menuItem('Acerca de esta sitio', tabName = 'about', icon = icon('info-circle')),
                              menuItem('Contacto', tags$li(a(onclick = "onclick = window.open('https://www.linkedin.com/in/eduardo-bacigalupe-nunes-43271719b/')",
                                                             href = NULL,
                                                             icon("linkedin"),
                                                             title = "LinkedIn",
                                                             style = "cursor: pointer;"),
                                                           class = "dropdown"))
          
                          )
                      ),
                      
                      dashboardBody(
                          tabItems(
                              tabItem(
                                  tabName = 'intro',
                                  
                                  fluidRow(
                                    column(6,
                                           tags$div(
                                             h1("El Suicidio"),
                                             tags$br(), "El suicidio es una de las principales causas de muerte no natural alrededor del mundo.
                                    Se producen cerca de 800.000 muertes de este tipo al año, afectando a familias,
                                    comunidades y países.",
                                             tags$br(), "Es un tipo de muerte que no entiende de edades, llegando a ser la principal causa de muerte 
                                    en personas de entre 15 y 29 años en todo el mundo.",
                                             tags$br(), "La sociedad se enfrenta a un grave problema de salud pública. No obstante, existe la posibilidad 
                                    de prevenir este tipo de muertes mediante intervenciones oportunas, basadas en datos y su correspondiente 
                                    analítica, llevando a cabo una estrategia de prevención del suicidio cuyo coste no seráa excesivamente elevado.",
                                             tags$br(), tags$br()
                                           )
                                    ),
                                    column(6,
                                           box(
                                             title = "Información",
                                             status = "primary",
                                             solidHeader = TRUE,
                                             h4('Kaggle'),
                                             tags$li(a(onclick = "onclick = window.open('https://www.kaggle.com/russellyates88/suicide-rates-overview-1985-to-2016')",
                                                       href = NULL,
                                                       icon("kaggle"),
                                                       title = "Saber más",
                                                       style = "cursor: pointer;"),
                                                     class = "dropdown"),
                                             tags$br(), h4('Organización Mundial de la Salud'),
                                             tags$li(a(onclick = "onclick = window.open('https://www.who.int/es/news-room/fact-sheets/detail/suicide')",
                                                       href = NULL,
                                                       icon("laptop-medical"),
                                                       title = "Saber más",
                                                       style = "cursor: pointer;"),
                                                     class = "dropdown"),
                                             tags$br(), h4('Instituto Nacional de Estadística'),
                                             tags$li(a(onclick = "onclick = window.open('https://www.ine.es/dynt3/inebase/es/index.htm?padre=5453&capsel=5454')",
                                                       href = NULL,
                                                       icon("chart-bar"),
                                                       title = "Saber más",
                                                       style = "cursor: pointer;"),
                                                     class = "dropdown")
                                           ),
                                           box(
                                             title = "Fuentes",
                                             status = "success",
                                             solidHeader = TRUE,
                                             img(src='kaggle.png', align = "left", width = 100, height = 40),
                                             tags$br(), tags$br(), img(src='oms.png', align = "left", width = 60, height = 60),
                                             tags$br(), tags$br(), tags$br(), tags$br(), img(src='ine.png', align = "left", width = 100, height = 40)
                                           )
                                    )
                                  ),
                                  
                              ),
                              tabItem(
                                  tabName = 'genero',
                                  
                                  fluidRow(
                                      column(6,
                                             infoBoxOutput('hombres', width = 15)
                                      ),
                                      column(6,
                                             infoBoxOutput('mujeres', width = 15)
                                      )
                                  ),
                                  
                                  tags$div(
                                    tags$br(), h3("Género en los suicidios"),
                                    tags$br(), "Existe una flagrante diferencia entre los hombres y las mujeres en términos de defunciones por suicidios. La curva de suicidios a lo largo del tiempo muestra que, 
                                    desde que se registran datos y hasta la fecha, el número de suicidios producidos por hombres es mucho más elevado que el producido por mujeres, 
                                    llegando a ser más del doble durante gran parte del tiempo.",
                                    tags$br(), "Un abrumador 76,89% de las muertes totales relacionadas con el suicidio son llevadas a cabo por el género masculino. 
                                    Esta cifra varía muy levemente si observamos individualmente cada país, cada franja de edad o cada año, lo que supone una afirmación muy preocupante.",
                                    tags$br(), tags$br(), tags$br() 
                                  ),
                                  
                                  fluidRow(
                                      column(12,
                                             box(
                                                 title = 'Suicidios por año según género',
                                                 width = 15,
                                                 status = 'primary',
                                                 collapsible = T, collapsed = F,
                                                 
                                                 fluidRow(
                                                     column(12,
                                                            radioGroupButtons(
                                                                inputId = 'check',
                                                                label = 'Mostrar',
                                                                choices = list('Total', 'Hombres' = 'male', 'Mujeres' = 'female'),
                                                                status = 'info'
                                                            )
                                                     )
                                                 )
                                             )
                                      )
                                  ),
                                  plotlyOutput('gender_plot')
                              ),
                              tabItem(
                                  tabName = 'pais',
                                  
                                  fluidRow(
                                      column(12, align = 'center',
                                             infoBoxOutput('muertesxpais', width = 15)
                                      )
                                  ),
                                  fluidRow(
                                      column(4,
                                             infoBoxOutput('poblacion', width = 10)
                                      ),
                                      column(4,
                                             infoBoxOutput('year', width = 10)
                                      ),
                                      column(4,
                                             infoBoxOutput('gdp_capita', width = 10)
                                      )
                                  ),
                                  fluidRow(
                                      column(12, align = 'center',
                                             box(width = 15, title = 'Paises', status = 'primary',
                                                 align = 'center',
                                                 solidHeader = TRUE, collapsible = TRUE,
                                                 collapsed = FALSE,
                                                 h4(strong('Indique Pais y Fecha')),
                                                 uiOutput('uiPais'),
                                                 uiOutput('uiYear')
                                             )
                                      )
                                  ),
                                  
                                  tags$div(
                                    tags$br(), h3("Relación PIB vs. Suicidios"),
                                    tags$br(), "Los factores socioeconómicos juegan un papel de suma importancia en esta problemática.",
                                    tags$br(), "El producto interior bruto per cápita y las muertes por suicidios por cada cien mil
                                    habitantes son dos variables que intervienen de manera significativa.",
                                    tags$br(), "Se encuentran tres grupos de países en relación con estas variables:", 
                                    tags$br(), "Los países cuyo PIB per cápita es bajo y, además, cuenta con un
                                    número de suicidios medio o elevado. Es considerado el grupo al que se le puede encontrar una relación directa entre las dos variables mencionadas, 
                                    siendo un grupo de mucho riesgo debido a que los propios países no disponen de los medios para afrontaresta situación.",
                                    tags$br(), "El segundo grupo lo forman países cuyo número de suicidios por cada cien mil habitantes es bajo, pero, no obstante, su PIB per cápita también es bajo.",
                                    tags$br(), "Por último, los países con un PIB per cápita medio o alto conforman el último clúster, ya que cuentan con una tasa de muertes por suicidio por cada cien mil habitantes de valor medio."
                                  )
                              ),
                              tabItem(
                                  tabName = 'edad',
                                  column(6,
                                         h4('Porcentaje de suicidios por franja de edad'),
                                         plotlyOutput('pie')
                                  ),
                                  column(6,
                                         box(
                                             width = 15, title = 'Filtros', status = 'primary',
                                             solidHeader = TRUE, collapsible = TRUE, collapsed = FALSE,
                                             uiOutput('genero_e'),
                                             uiOutput('pais_e')
                                         ),
                                         box(
                                           width = 15, title = 'Info', status = 'success',
                                           solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
                                           tags$div(
                                             "La edad también es una variable que muestra un grupo predominante. Una mayoría simple del 36,34% de las muertes por suicidio se 
                                             han producido en la franja de edad de los 35 a los 54 años, seguida por la franja de los 55 a los 74 años, con un 24,58% del total. 
                                             Mayoría de ambos grupos que también es visible si se diferencia entre hombre y mujeres.",
                                             tags$br(), "Las muertes relacionadas con el suicidio que pertenecen a la franja de edad de los 35 a los 54 años suponen el 36,34% de las muertes totales. 
                                             Esta franja de edad también es superior al resto si se observa cada país, cada año o por género individualmente."
                                           )
                                         )
                                  )
                              ),
                              
                              tabItem(
                                tabName = 'about',
                                tags$div(
                                  tags$h3("Origen de los datos"),
                                  "Los datos obtenidos para la realización de esta aplicación han sido extraidos de la web",
                                  tags$a(href = "https://www.kaggle.com/", "Kaggle"), ", la comunidad 'data science' más grande del mundo.",
                                  "En concreto, el dataset utilizado es", 
                                  tags$a(href = "https://www.kaggle.com/russellyates88/suicide-rates-overview-1985-to-2016", "Suicides Rates Overview 1985 to 2016"), 
                                  ", que compara información socio-económica con ratios de suicidio por año y país.",
                                  
                                  tags$br(),tags$br(),tags$h3("Inspiración"),
                                  "Cada dos horas y media se suicida una persona en España, diez al día: los muertos por suicidio duplican a los de accidentes de tráfico, superan en once veces a los homicidios y en ochenta a los de violencia de género.", 
                                  tags$br(), "Uno de los objetivos de la creación de esta aplicación es dar visibilidad a este tipo de muertes.",
                                  
                                  tags$br(),tags$br(),tags$h3("Enlaces de intrés"),
                                  tags$a(href = "https://www.ine.es/dynt3/inebase/es/index.htm?padre=5453&capsel=5454", "Defunciones por suicidio"), " - Instituto Nacional de Estadística",
                                  tags$br(), tags$a(href = "https://telefonodelaesperanza.org/", "Teléfono de la Esperanza"),
                                  tags$br(), tags$a(href = "https://www.who.int/mental_health/prevention/suicide/suicideprevent/es/", "Prevención del suicidio"), " - Organización Mundial de la Salud", 
                                  
                                  
                                  tags$br(),tags$br(),tags$h3("Autores"),
                                  "Juan Manuel Cermeño González",tags$br(),
                                  tags$a(href = "https://www.linkedin.com/in/eduardo-bacigalupe-nunes-43271719b/", "Eduardo Bacigalupe Nunes"), 
                                  
                                  tags$br(),tags$br(),tags$h3("Contacto"),
                                  img(src='eae.png', align = "right", width = 250, height = 50),
                                  "juanmaceg@gmail.com",tags$br(),
                                  "ebacigalupenunes@gmail.com",
                                  
                                )
                              )
                          )
                      )
                      
)

)
