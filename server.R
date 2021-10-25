shinyServer(function(input, output) {
  
  ######## Paises ########
  
  # Reactive Paises
  
  paisesReactive <- reactive({
    suicidios['country'] %>% 
      dplyr::distinct() %>% 
      dplyr::arrange(country) %>%
      dplyr::pull(country)
  })
  
  yearReactive<- reactive({
    suicidios['year'] %>% 
      dplyr::distinct() %>% 
      dplyr::arrange(year) %>%
      dplyr::pull(year)
  })
  
  boxesPaises <- reactive({
    totales <- suicidios %>% 
      group_by(country) %>% 
      dplyr::filter(year == input$yearSuic) %>%
      dplyr::summarise(Suicidiosxpais = sum(suicides_no),
                       Poblacion = sum(population),
                       #Year = year,
                       RentaperCapita = sum(gdp_capita)) %>% 
      #dplyr::filter(year == input$yearSuic) %>%
      dplyr::filter(country == input$paisSuic)
    
    list(
      Suicidiosxpais = totales$Suicidiosxpais,
      Poblacion = totales$Poblacion,
      Year = totales$Year,
      RentaperCapita = totales$RentaperCapita
    )
  })
  
  # UI Box Paises
  
  output$uiPais <- renderUI({
    pickerInput(inputId = 'paisSuic', label = 'Pais', choices = paisesReactive())
  })
  
  output$uiYear <- renderUI({
    pickerInput(inputId = 'yearSuic', label = 'Year' , choices = yearReactive())
  })
  
  # VALUE BOX PAISES
  
  
  output$muertesxpais <- renderInfoBox({
    muertes = boxesPaises()$Suicidiosxpais 
    infoBox( 'Número de Suicidos', muertes, 
             icon = icon('skull-crossbones'),color = 'black', fill = TRUE )
  })
  
  output$poblacion <- renderInfoBox ({
    pob = boxesPaises()$Poblacion
    infoBox( 'Población', pob, 
             icon = icon('users'), color = 'lime', fill = TRUE )
  })
  
  output$year <- renderInfoBox ({
    #year = boxesPaises()$Year
    year = input$yearSuic
    infoBox( 'Año', year, 
             icon = icon('calendar-alt'), color = 'light-blue', fill = TRUE )
  })
  
  output$gdp_capita <- renderInfoBox ({
    gdp_cabeza = boxesPaises()$RentaperCapita
    infoBox( 'Renta per Cáptita', gdp_cabeza, 
             icon = icon('money-bill-alt'), color = 'green', fill = TRUE )
  })
  
  ######## Genero ########
  
  # Reactive Genero
  
  totales_genero <- reactive({
    
    genero_n = suicidios %>%
      dplyr::group_by(sex) %>%
      dplyr::summarise(total_h = sum(suicides_no))
    male_percent = round((genero_n$total_h[genero_n$sex == 'male']/sum(genero_n$total_h))*100, 2)
    female_percent = round((genero_n$total_h[genero_n$sex == 'female']/sum(genero_n$total_h))*100, 2)
    
    list(
      male_percent = paste(male_percent, '%'),
      female_percent = paste(female_percent, '%')
    )
    
  })
  
  grafica_genero <- reactive({
    
    suicidios_ano = suicidios %>%
      dplyr::group_by(year) %>%
      dplyr::summarise(suicides = sum(suicides_no))
    
    suicidios_h_ano <- suicidios %>%
      dplyr::filter(sex == 'male') %>%
      dplyr::group_by(year) %>%
      dplyr::summarise(suicides = sum(suicides_no))
    
    suicidios_m_ano <- suicidios %>%
      dplyr::filter(sex == 'female') %>%
      dplyr::group_by(year) %>%
      dplyr::summarise(suicides = sum(suicides_no))
    
    suicidios_total <- data.frame('Año' = suicidios_ano$year,
                                  'Suicidios' = suicidios_ano$suicides,
                                  'Hombres' = suicidios_h_ano$suicides,
                                  'Mujeres' = suicidios_m_ano$suicides)
    
    suicidios_total <- suicidios_total[-32,]
    
    
    suicidios_total
    
  })
  
  # Output Genero
  
  ## InfoBox
  
  output$hombres <- renderInfoBox({
    
    valor1 <- totales_genero()$male_percent
    infoBox('Porcentaje total de hombres', valor1, icon = icon('mars'), color = 'olive', fill = TRUE)
    
  })
  
  output$mujeres <- renderInfoBox({
    
    valor2 <- totales_genero()$female_percent
    infoBox('Porcentaje total de mujeres', valor2, icon = icon('venus'), color = 'light-blue', fill = TRUE)
    
  })
  
  ## Plot
  
  output$gender_plot <- renderPlotly({
    
    plot <- ggplot(grafica_genero()) + 
      geom_line(aes(x = Año, y = Suicidios), color = '#EF553B') +
      geom_line(aes(x = Año, y = Hombres), color = '#54A24B') +
      geom_line(aes(x = Año, y = Mujeres), color = 'midnightblue') +
      geom_point(aes(x = Año, y = Suicidios), size = 1, alpha = 0.8, color = '#EF553B') +
      geom_point(aes(x = Año, y = Hombres), size = 1, alpha = 0.8, color = '#54A24B') +
      geom_point(aes(x = Año, y = Mujeres), size = 1, alpha = 0.8, color = 'midnightblue') + 
      theme_bw()
    
    if(input$check == 'male'){
      plot <- ggplot(grafica_genero()) + 
        geom_line(aes(x = Año, y = Suicidios), color = '#EF553B') +
        geom_line(aes(x = Año, y = Hombres), color = '#54A24B') + 
        geom_point(aes(x = Año, y = Suicidios), size = 1, alpha = 0.8, color = '#EF553B') + 
        geom_point(aes(x = Año, y = Hombres), size = 1, alpha = 0.8, color = '#54A24B') +
        theme_bw()
    }
    
    else if(input$check == 'female'){
      plot <- ggplot(grafica_genero()) + 
        geom_line(aes(x = Año, y = Suicidios), color = '#EF553B') +
        geom_line(aes(x = Año, y = Mujeres), color = 'midnightblue')+ 
        geom_point(aes(x = Año, y = Suicidios), size = 1, alpha = 0.8, color = '#EF553B') +
        geom_point(aes(x = Año, y = Mujeres), size = 1, alpha = 0.8, color = 'midnightblue') + 
        theme_bw()
    }
    
    ggplotly(plot)
    
  })
  
  
  ########  Edad  ########
  
  # Reactive Edad
  
  pais_select <- reactive({
    
    paises = suicidios %>%
      dplyr::group_by(country) %>%
      dplyr::summarise(country = unique(country))
    
    paises
    
  })
  
  gen_select <- reactive({
    
    sex <- suicidios %>%
      dplyr::group_by(sex) %>%
      dplyr::summarise(sex = unique(sex))
    
    sex
    
  })
  
  data_plot <- reactive({
    
    total <- sum(suicidios$suicides_no)
    
    pie <- suicidios %>%
      dplyr::group_by(age) %>%
      dplyr::summarise(percentage = round((sum(suicides_no)/total)*100, 2))
    
    if (input$selector != 'All') {
      
      total <- sum(suicidios$suicides_no[suicidios$country == input$selector])
      
      pie <- suicidios %>%
        dplyr::group_by(age) %>%
        dplyr::summarise(percentage = round((sum(suicides_no[country == input$selector])/total)*100, 2))
      
    }
    
    if (input$sexo_gen != 'All') {
      
      total <- sum(suicidios$suicides_no[suicidios$sex == input$sexo_gen])
      
      pie <- suicidios %>%
        dplyr::group_by(age) %>%
        dplyr::summarise(percentage = round((sum(suicides_no[sex == input$sexo_gen])/total)*100, 2))
      
    }
    
    pie
    
  })
  
  # Output Edad
  
  ## uiOutput
  
  output$genero_e <- renderUI({
    
    selectInput('sexo_gen', 'Sexo', choices = c('All', gen_select()), selected = 'All')
  })
  
  output$pais_e <- renderUI({
    
    selectInput('selector', 'Pais', choices = c('All', pais_select()), selected = 'All')
    
  })
  
  #Visualizacion del plot
  
  output$pie <- renderPlotly({
    
    data_pl <- data_plot()
    
    pie_plot <- ggplot(data_pl, aes(x = age, y = percentage , fill = age)) +
      geom_bar(stat = "identity", width = 1) +
      xlab("Edad") + 
      ylab("Número de Suicidios") +
      theme_void() +
      theme(legend.position="none") +
      
      scale_fill_brewer(palette="Spectral")
    
    ggplotly(pie_plot)
  
  })
  
})
