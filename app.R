library(bs4Dash)
library(mongolite)
library(shinyWidgets)

useSweetAlert()

conn <- mongo("encuesta", url = "mongodb+srv://170300075:Maripau01@cluster0.ynkmfoz.mongodb.net/ciam")

# Lista de variables
estados_civiles <- c("Solter@", "Casad@", "Viud@", "Separad@", "Divorciad@", "Unión libre")
ingresos_mensuales <- c("$2,699 o menos", "$2,700 - $6,799", "$6,800 - $11,599", "$11,600 - $34,999", "$35,000 - $84,000", "$85,000 o más")
parentesco <- c("Yo", "Conyugue", "Pareja", "Hija", "Hijo", "Madre", "Padre", "Hermana", "Hermano", "Abuela", "Abuelo", "Tía", "Tío", "Prima", "Primo", "Cuñada", "Cuñado", "Sobrina", "Sobrino", "Roomie")
sectores_economicos <- c("Sector de agricultura, ganadería, explotación y aprovechamiento forestal, pesca y caza",
"Minería", "Sector energético (electricidad, agua, gas y petróleo)", "Construcción", "Industria manufacturera", "Comercio", "Transportes, correos y almacenamiento", "Información en medios masivos", 
"Servicios financieros y de seguros", "Servicios inmobiliarios, alquiler de bienes muebles e intagibles", "Servicios profesionales, científicos y técnicos", "Corporativos",
"Servicios de apoyo a negocios, manejo de residuos y desechos o servicios de reparación", "Servicios educativos", "Servicios de salud y asistencia social",
"Servicios de esparcimiento cultural/deportivo y otros servicios recreativos", "Hotelería/Preparación de alimentos y bebidas", "Actividades gubernamentales")
rangos_edad_hijos <- c("0 - 5 años", "6 - 15 años", "15 - 22 años", "23 años en adelante")
servicios_medicos <- c("Ninguno", "IMSS", "ISSSTE", "Seguro Popular", "Gastos Médicos Mayores")
grados_estudios <- c("Sin estudios", "Preescolar", "Primaria", "Secundaria", "Bachillerato", "Licenciatura", "Maestría", "Doctorado")
principales_necesidades <- c("Cubrir alimentación", "Acompañamiento psicológico", "Cuidado de hij@s", "Ayuda por causa de violencia", "Apoyo pedagógico", "Apoyo médico", "Apoyo jurídico", "Ninguna", "Otra")
cuidadores <- c("Se queda(n) solo(s) en casa", "Madre", "Padre", "Madrastra", "Padrastro", "Herman@ mayor", "Abuel@", "Tí@", "Conocido (Vecin@, Amig@, Roomie)")
regiones <- c("3 Hermanos","ABC","Álamos I","Andalucia","Andalucia II","Arboledas","Bahía Dorada","Bahía Real","Bosques San Miguel","Campestre","Cancún Centro","Casas del Mar", 
"Central de Abasto","Central de Bodegas","Chamuyil","Costa del Mar","Del Bosque","Doctores II","Donceles","Fraccionamiento Galaxia Altamar","Framboyanes","Francisco Villa",
"Galaxia del Cielo","Galaxia del Sol","Galaxia las Torres","Generación 2000","Grand Santa Fe","Grand Santa Fe 2","Gran Santa Fe","Guadalupana","Guerrero","Hacienda Del Rey",
"Hacienda Real del Caribe","In House","Ixchel","Jardines Cancún","Jardines de Banampak","Jardines del Sur","Juárez","K.M 308","K.M 309","La Amistad","La Cascada","Lagos",
"Lagos del Sol","La Guadalupana","La Herradura","La Joya (Supermanzana 254)","La Morena","Las Lajas","Las Torres","Lombardo Toledano","Los Cedros","Los Héroes","Los Santos",
"Malibú","Mallorca","México","Monte de los Olivos","Monte Real","Nueva Esperanza","Paraíso Cancún","Paraíso Maya","Paraíso Villas","Paseo de Las Palmas","Paseos del Sol (Supermanzana 205)",
"Petén","Porto Alegre","Prado Norte","Privanza Stellaris","Puerta del Mar","Puerta Del Sol","Punta Sam","Quetzal Región 523","Quinta las Joyas","Quintas","Real Las Quintas (Supermanzana 202)",
"Real Valencia","Región 100","Región 101","Región 102","Región 103","Región 203 (Cuna Maya)","Región 219","Región 220","Región 221","Región 227","Región 228","Región 229","Región 230","Región 231",
"Región 232","Región 233","Región 234","Región 235","Región 236","Región 237","Región 238","Región 239","Región 240","Región 240","Región 500","Región 501","Región 502","Región 503","Región 504",
"Región 505","Región 506","Región 507","Región 508","Región 509","Región 510","Región 511","Región 512","Región 513","Región 514","Región 515","Región 516","Región 517","Región 518","Región 519",
"Región 520","Región 521","Región 522","Región 84","Región 90","Región 91","Región 92","Región 93","Región 94","Región 95","Región 96","Región 97","Región 98","Región 99","Residencial Caracol",
"Residencial San Antonio","Rinconada Santa María","San José Bonampack","San Martín Caballero","Santa Cecilia","Santa Fe","Santa Fe Plus","SM 207 Villas del Sol II","SM 21","SM 256","SM 260",
"SM 327","SM 534","SM 90","Sol del Mayab","Supermanzana 10","Supermanzana 104","Supermanzana 105","Supermanzana 106","Supermanzana 107","Supermanzana 11","Supermanzana 117","Supermanzana 11a",
"Supermanzana 12","Supermanzana 12a","Supermanzana 12b","Supermanzana 13","Supermanzana 14","Supermanzana 14 A","Supermanzana 15","Supermanzana 15a","Supermanzana 16","Supermanzana 17",
"Supermanzana 18","Supermanzana 19","Supermanzana 1 Centro","Supermanzana 200","Supermanzana 209","Supermanzana 20 Centro","Supermanzana 210","Supermanzana 211","Supermanzana 212",
"Supermanzana 216","Supermanzana 217","Supermanzana 218","Supermanzana 222","Supermanzana 223","Supermanzana 225","Supermanzana 226","Supermanzana 22 Centro","Supermanzana 23 Centro",
"Supermanzana 24","Supermanzana 241","Supermanzana 245","Supermanzana 248","Supermanzana 25","Supermanzana 253","Supermanzana 26","Supermanzana 27","Supermanzana 28","Supermanzana 29",
"Supermanzana 2a Centro","Supermanzana 2 Centro","Supermanzana 30","Supermanzana 300","Supermanzana 301","Supermanzana 31","Supermanzana 312","Supermanzana 316","Supermanzana 317",
"Supermanzana 318","Supermanzana 319","Supermanzana 32","Supermanzana 320","Supermanzana 321","Supermanzana 325","Supermanzana 326","Supermanzana 33","Supermanzana 34","Supermanzana 35",
"Supermanzana 36","Supermanzana 37","Supermanzana 38","Supermanzana 39","Supermanzana 3 Centro","Supermanzana 40","Supermanzana 41","Supermanzana 42","Supermanzana 43","Supermanzana 44",
"Supermanzana 45","Supermanzana 46","Supermanzana 47","Supermanzana 48","Supermanzana 49","Supermanzana 4 A","Supermanzana 4 Centro","Supermanzana 50","Supermanzana 51","Supermanzana 52",
"Supermanzana 524","Supermanzana 524-2","Supermanzana 525","Supermanzana 526","Supermanzana 527","Supermanzana 528","Supermanzana 529","Supermanzana 529-1","Supermanzana 53","Supermanzana 530-1",
"Supermanzana 531","Supermanzana 532","Supermanzana 55","Supermanzana 550","Supermanzana 56","Supermanzana 57","Supermanzana 58","Supermanzana 59","Supermanzana 5 Centro","Supermanzana 60",
"Supermanzana 61","Supermanzana 62","Supermanzana 63","Supermanzana 64","Supermanzana 65","Supermanzana 66","Supermanzana 67","Supermanzana 68","Supermanzana 69","Supermanzana 6a",
"Supermanzana 6b","Supermanzana 6c","Supermanzana 6d","Supermanzana 6e","Supermanzana 6f","Supermanzana 7","Supermanzana 70","Supermanzana 71","Sup
ermanzana 72","Supermanzana 73",
"Supermanzana 74","Supermanzana 75","Supermanzana 76","Supermanzana 77","Supermanzana 78","Supermanzana 79","Supermanzana 8","Supermanzana 85","Supermanzana 86","Supermanzana 89",
"Supermanzana 9","Tierra Maya","Tucanes","Unidad Morelos","Urbi Villas del rey","Villa Marino","Villas de Alba","Villas del Arte","Villas Del Caribe","Villas del Mar Plus",
"Villas de Thio","Villas Otoch","Villas Otoch Paraíso","Villas Tropicales","Vista Real","Zona Hotelera")

formInput <- function(my_title = NULL, content = NULL){
    div(
        box(
            title = my_title,
            status = "indigo",
            headerBorder = FALSE,
            solidHeader = FALSE,
            collapsible = FALSE,
            elevation = 1,
            width = 12,
            content
        ),

        br()
    )
}

question <- function(text = NULL) {
    p(text, class = "lead mb-1")
}

header <- dashboardHeader(
    title = h5("CIAM Cancún | Análisis de la población", class = "p-3 text-white"),
    compact = FALSE, 
    border = FALSE,
    status = "indigo",
    fixed = TRUE
)

# Deshabilitar la barra lateral
sidebar <- dashboardSidebar(disable = TRUE)

body <- dashboardBody(
    fluidRow(
        column(
            width = 5,
            class = "mx-auto mt-5",

            uiOutput("p1"),
            uiOutput("p2"),
            uiOutput("p3"),
            uiOutput("p4"),
            uiOutput("p5"),
            uiOutput("p6"),
            uiOutput("p7"),
            uiOutput("p8"),
            uiOutput("p9"),
            uiOutput("p10"),
            uiOutput("p11"),
            uiOutput("p12"),
            uiOutput("p13"),
            uiOutput("p14"),
            uiOutput("p15"),
            uiOutput("p16"),
            uiOutput("p17"),
            uiOutput("p18"),
            uiOutput("p19"),
            uiOutput("p20"),
            uiOutput("p21"),
            uiOutput("p22"),
            uiOutput("p23"),
            uiOutput("p24"),
            actionButton(inputId = "submit", label = "Enviar", width = "100%", style = "background: indigo; color:white;")
        )
    )
)

footer <- dashboardFooter(left = HTML("<b>CIAM Cancún</b> &copy; Empoderando a las mujeres <i class='fa-solid fa-heart fa-beat' style='color: purple'></i>"))

ui <- dashboardPage(header = header, sidebar = sidebar, body =  body, footer = footer)

server <- function(input, output, session) {
    values <- reactiveValues() 

    output$p1 <- renderUI({
        formInput(
            my_title = "Pregunta 1",
            textInput(
                inputId = "nombre",
                label = question("¿Cuál es tu nombre completo?"),
                placeholder = "Tu nombre completo"
            )
        )
    })

    output$p2 <- renderUI({
        formInput(
            my_title = "Pregunta 2",
            numericInput(
                inputId = "edad",
                label = question("¿Cuál es tu edad? (en años)"),
                value = NULL,
                min = 0, max = 110, step = 1
            )
        )
    })

    output$p3 <- renderUI({
        formInput(
            my_title = "Pregunta 3",
            selectInput(
                inputId = "sexo",
                label = question("¿Cuál es tu sexo?"),
                choices = c("Mujer", "Hombre")
            )
        )
    })

    output$p4 <- renderUI({
        formInput(
            my_title = "Pregunta 4",
            selectInput(
                inputId = "estado_civil",
                label = question("¿Cuál es tu estado civil?"),
                choices = estados_civiles
            )
        )
    })

    output$p5 <- renderUI({
        formInput(
            my_title = "Pregunta 5",
            radioButtons(
                inputId = "sabe_leer_escribir",
                label = question("¿Sabes leer y/o escribir?"),
                choices = c("No", "Sí"),
                selected = character(0)
            )
        )
    })

    output$p6 <- renderUI({
        formInput(
            my_title = "Pregunta 6",
            div(
                radioButtons(
                    inputId = "habla_lengua_indigena",
                    label = question("¿Hablas alguna lengua indigena?"),
                    choices = c("No", "Sí")
                ),

                uiOutput("p6_a")
            )
        )
    })

    output$p6_a <- renderUI({
        if(input$habla_lengua_indigena == "Sí"){
            textInput(
                inputId = "cual_lengua_indigena",
                label = question("¿Cuál?"),
                placeholder = "Escribe..."
            )
        }
    })

    output$p7 <- renderUI({
        formInput(
            my_title = "Pregunta 7",
            selectInput(
                inputId = "ingresos_mensuales",
                label = question("¿Cuáles son los ingresos mensuales del hogar?"),
                choices = ingresos_mensuales,
                selected = NULL
            )
        )
    })
    
    output$p8 <- renderUI({
        formInput(
            my_title = "Pregunta 8",
            selectInput(
                inputId = "viven_misma_vivienda",
                label = question("¿Quiénes viven en la misma vivienda? Selecciona los que apliquen"),
                choices = parentesco,
                multiple = TRUE,
                selected = NULL
            )
        )
    })

    output$p9 <- renderUI({
        formInput(
            my_title = "Pregunta 9",
            numericInput(
                inputId = "personas_trabajadoras",
                label = question("De las personas que viven en el hogar, ¿Cuántos trabajan?"),
                value = NULL,
                min = 0, max = 20, step = 1
            )
        )
    })

    output$p10 <- renderUI({
        formInput(
            my_title = "Pregunta 10",
            selectInput(
                inputId = "principal_ingreso",
                label = question("¿Quién aporta el principal ingreso económico del hogar?"),
                choices = c("Yo", parentesco),
                multiple = FALSE,
                selected = NULL
            )
        )
    })

    output$p11 <- renderUI({
        formInput(
            my_title = "Pregunta 11",
            selectInput(
                inputId = "sector_economico",
                label = question("¿En qué sector trabaja esa persona?"),
                choices = sectores_economicos,
                multiple = FALSE,
                selected = NULL
            )
        )
    })

    output$p12 <- renderUI({
        formInput(
            my_title = "Pregunta 12",
            numericInput(
                inputId = "horas_laborales",
                label = question("¿Cuántas hora labora a la semana esa persona?"),
                value = NULL,
                min = 0, max = 168, step = 1
            )
        )
    })

    output$p13 <- renderUI({
        formInput(
            my_title = "Pregunta 13",
            numericInput(
                inputId = "horas_llegar_trabajo",
                label = question("¿Cuántos minutos le toma llegar al trabajo?"),
                value = NULL,
                min = 0, max = 500, step = 1
            )
        )
    })

    output$p14 <- renderUI({
        formInput(
            my_title = "Pregunta 14",
            div(
                numericInput(
                    inputId = "cantidad_hijas",
                    label = question("¿Cuántas hijas tiene?"),
                    value = 0,
                    min = 0, max = 50, step = 1
                ),

                numericInput(
                    inputId = "cantidad_hijos",
                    label = question("¿Cuántos hijos tiene?"),
                    value = 0,
                    min = 0, max = 50, step = 1
                )
            )
        )
    })

    output$p15 <- renderUI({
        values$hijxs <- input$cantidad_hijas + input$cantidad_hijos

        if(values$hijxs > 0){
            formInput(
                my_title = "Pregunta 15",
                selectInput(
                    inputId = "cuida_hijos",
                    label = question("Mientras las personas que aportan ingresos al hogar están trabajando, mayormente, ¿Quién cuida a los niños?"),
                    choices = c(cuidadores),
                    multiple = FALSE,
                    selected = NULL
                )
            )
        }
    })

    # Si tiene hijos, mostrar esta pregunta
    output$p16 <- renderUI({
        if(values$hijxs > 0){
            formInput(
                my_title = "Pregunta 16",
                numericInput(
                    inputId = "asistencia_escolar",
                    label = question("¿Cuántos de sus hij@s asisten a la escuela?"),
                    value = NULL,
                    min = 0, max = 50, step = 1 
                )
            )
        }
    })

    output$p17 <- renderUI({
        if(values$hijxs > 0){
            formInput(
                my_title = "Pregunta 17",
                selectInput(
                    inputId = "rango_edad_hijos",
                    label = question("Rango de edad de sus hijos e hijas. (Selecione los rangos de edad aplicables)"),
                    choices = rangos_edad_hijos,
                    multiple = TRUE,
                    selected = NULL
                )
            )
        }
    })

    output$p18 <- renderUI({
        formInput(
                my_title = "Pregunta 18",
                selectInput(
                    inputId = "servicio_medico",
                    label = question("¿A qué servicio médico pertenece?"),
                    choices = servicios_medicos,
                    multiple = FALSE,
                    selected = NULL
                )
            )
    })


    output$p19 <- renderUI({
        formInput(
            my_title = "Pregunta 19",
            selectInput(
                inputId = "supermanzana_vivienda",
                label = question("¿En qué región, supermanzana o colonia vive actualmente?"),
                choices = regiones,
                multiple = FALSE,
                selected = NULL
            )
        )
    })

    output$p20 <- renderUI({
        formInput(
            my_title = "Pregunta 20",
            
            div(
                selectInput(
                    inputId = "ultimo_grado_estudios",
                    label = question("¿Cuál es el último grado de estudios del principal ingreso económico del hogar?"),
                    choices = grados_estudios,
                    multiple = FALSE,
                    selected = NULL
                ),

                uiOutput("p20_a")
            )
        )
    })

    output$p20_a <- renderUI({
        if(input$principal_ingreso != "Yo"){
            selectInput(
                inputId = "ultimo_grado_estudios_encuestado",
                label = question("¿Cuál es tu último grado de estudios?"),
                choices = grados_estudios,
                multiple = FALSE,
                selected = NULL
            )
        }
    })

    output$p21 <- renderUI({
        formInput(
            my_title = "Pregunta 21",
            div(
                selectInput(
                    inputId = "principales_necesidades",
                    label = question("¿Cuál es la principal necesidad de su familia?"),
                    choices = principales_necesidades,
                    multiple = FALSE,
                    selected = NULL
                ),

                uiOutput("p21_a")
            )
        )
    })

    output$p21_a <- renderUI({
        if(input$principales_necesidades == "Otra"){
            textInput(
                inputId = "cual_principal_necesidad",
                label = question("¿Cuál?")
            )
        }
    })

    output$p22 <- renderUI({
        formInput(
            my_title = "Pregunta 22",
            div(
                radioButtons(
                    inputId = "conoce_ciam",
                    label = question("¿Conoce el CIAM?"),
                    choices = c("No", "Sí")
                ),

                uiOutput("p22_a")
            )
        )
    })

    output$p22_a <- renderUI({
        if(input$conoce_ciam == "No"){
            p("El CIAM es a todo dar")
        }
    })

    output$p23 <- renderUI({
        if(input$conoce_ciam == "Sí"){
          formInput(
              my_title = "Pregunta 23",
              textAreaInput(
                  inputId = "actividades_recomendadas",
                  label = question("¿Qué actividades/servicios adicionales te gustaría que el CIAM ofreciera?"),
                  placeholder = "Nos ayudarás mucho con tus comentarios",
                  resize = "vertical"
  
              )
          )
        }
    })

    observeEvent(input$submit, {
        datos <- list(
            nombre = input$nombre, 
            edad = input$edad,
            sexo = input$sexo,
            estado_civil = input$estado_civil,
            sabe_leer_escribir = input$sabe_leer_escribir,
            habla_lengua_indigena = input$habla_lengua_indigena,
            ingresos_mensuales = input$ingresos_mensuales,
            viven_misma_vivienda = input$viven_misma_vivienda,
            personas_trabajadoras = input$personas_trabajadoras,
            principal_ingreso = input$principal_ingreso,
            sector_economico = input$sector_economico,
            horas_laborales = input$horas_laborales,
            minutos_llegar_trabajo = input$horas_llegar_trabajo,
            quien_cuida_hijos = input$cuida_hijos,
            asistencia_escolar = input$asistencia_escolar,
            cantidad_hijas = input$cantidad_hijas,
            cantidad_hijos = input$cantidad_hijos,
            rango_edad_hijos = input$rango_edad_hijos,
            servicio_medico = input$servicio_medico,
            supermanzana_vivienda = input$supermanzana_vivienda,
            ultimo_grado_estudios_principal_ingreso = input$ultimo_grado_estudios,
            ultimo_grado_estudios_encuestado = input$ultimo_grado_estudios_encuestado,
            principales_necesidades = input$principales_necesidades,
            conoce_ciam = input$conoce_ciam,
            actividades_recomendadas = input$actividades_recomendadas,
            hora_encuesta = Sys.time()
        )

        conn$insert(datos)

        ask_confirmation(
            inputId = "confirmacion",
            title = "¡Respuestas enviadas!",
            text = "Te agradecemos por haber contestado esta encuesta",
            type = "success",
            btn_labels = "Entendido!",
            closeOnClickOutside = TRUE,
            showCloseButton = TRUE
        )
    })

    observeEvent(input$confirmacion, {
        session$reload()
    })
}

options(shiny.autoreload = TRUE)
options(shiny.port = 3000)
shinyApp(ui, server)