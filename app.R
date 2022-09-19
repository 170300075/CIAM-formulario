library(bs4Dash)

# Lista de variables
estados_civiles <- c("Soltera", "Casada", "Viuda", "Separada", "Divorciada", "Unión libre")
ingresos_mensuales <- c("$2,699 o menos", "$2,700 - $6,799", "$6,800 - $11,599", "$11,600 - $34,999", "$35,000 - $84,000", "$85,000 o más")
parentesco <- c("Conyugue", "Pareja", "Hija", "Hijo", "Madre", "Padre", "Abuela", "Abuelo", "Tía", "Tío", "Cuñada", "Cuñado", "Sobrina", "Sobrino", "Roomie")
sectores_economicos <- c("Sector de agricultura, ganadería, explotación y aprovechamiento forestal, pesca y caza",
"Minería", "Sector energético (electricidad, agua, gas y petróleo)", "Construcción", "Industria manufacturera", "Comercio al por mayor", 
"Comercio al por menor", "Transportes, correos y almacenamiento", "Información en medios masivos", "Servicios financieros y de seguros",
"Servicios inmobiliarios, alquiler de bienes muebles e intagibles", "Servicios profesionales, científicos y técnicos", "Corporativos",
"Servicios de apoyo a negocios, manejo de residuos y desechos o servicios de remediación", "Servicios educativos", "Servicios de salud y asistencia social",
"Servicios de esparcimiento cultural/deportivo y otros servicios recreativos", "Hotelería/Preparación de alimentos y bebidas",
"Actividades gubernamentales")
rangos_edad_hijos <- c("0 - 5 años", "6 - 15 años", "15 - 22 años", "23 años en adelante")
servicios_medicos <- c("Ninguno", "IMSS", "ISSSTE", "Seguro Popular", "Gastos Médicos Mayores")
listado_supermanzanas <- c("Sm. 252")
grados_estudios <- c("Sin grado de estudios", "Preescolar", "Primaria", "Secundaria", "Bachillerato", "Licenciatura", "Maestría", "Doctorado")
principales_necesidades <- c("Cubrir alimentación", "Acompañamiento psicológico", "Cuidado de hij@s", "Ayuda por causa de violencia", "Apoyo pedagógico", "Ninguna")



formInput <- function(my_title = NULL, content = NULL){
    div(
        box(
            title = my_title,
            status = "indigo",
            headerBorder = FALSE,
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
    status = "purple",
    fixed = TRUE
)

# Deshabilitar la barra lateral
sidebar <- dashboardSidebar(disable = TRUE)

body <- dashboardBody(
    fluidRow(
        column(
            width = 5,
            class = "mx-auto mt-5",

            formInput(
                my_title = "Pregunta 1",
                textInput(
                    inputId = "nombre",
                    label = question("¿Cuál es tu nombre?"),
                    placeholder = "Tu nombre completo"
                )
            ),

            formInput(
                my_title = "Pregunta 2",
                numericInput(
                    inputId = "edad",
                    label = question("¿Cuál es tu edad? (en años)"),
                    value = NULL,
                    min = 0, max = 110, step = 1
                )
            ),

            formInput(
                my_title = "Pregunta 3",
                selectInput(
                    inputId = "sexo",
                    label = question("¿Cuál es tu sexo?"),
                    choices = c("Mujer", "Hombre"),
                    selected = NULL
                )
            ),

            formInput(
                my_title = "Pregunta 4",
                selectInput(
                    inputId = "estado_civil",
                    label = question("¿Cuál es tu estado civil?"),
                    choices = estados_civiles,
                    selected = NULL
                )
            ),

            formInput(
                my_title = "Pregunta 5",
                selectInput(
                    inputId = "ingresos_mensuales",
                    label = question("¿Cuáles son los ingresos mensuales del hogar?"),
                    choices = ingresos_mensuales,
                    selected = NULL
                )
            ),

            formInput(
                my_title = "Pregunta 6",
                selectInput(
                    inputId = "viven_misma_vivienda",
                    label = question("¿Quiénes viven en la misma vivienda?"),
                    choices = parentesco,
                    multiple = TRUE,
                    selected = NULL
                )
            ),

            formInput(
                my_title = "Pregunta 7",
                numericInput(
                    inputId = "personas_trabajadoras",
                    label = question("¿Cuántas personas trabajan?"),
                    value = NULL,
                    min = 0, max = 20, step = 1
                )
            ),

            formInput(
                my_title = "Pregunta 8",
                selectInput(
                    inputId = "principal_ingreso",
                    label = question("¿Quién aporta el principal ingreso económico del hogar?"),
                    choices = c("Yo", parentesco),
                    multiple = FALSE,
                    selected = NULL
                )
            ),

            formInput(
                my_title = "Pregunta 9",
                selectInput(
                    inputId = "sector_economico",
                    label = question("¿En qué sector trabaja esa persona?"),
                    choices = sectores_economicos,
                    multiple = FALSE,
                    selected = NULL
                )
            ),

            formInput(
                my_title = "Pregunta 10",
                numericInput(
                    inputId = "horas_laborales",
                    label = question("¿Cuántas hora labora a la semana esa persona?"),
                    value = NULL,
                    min = 0, max = 168, step = 1 
                )
            ),

            formInput(
                my_title = "Pregunta 11",
                numericInput(
                    inputId = "horas_llegar_trabajo",
                    label = question("¿Cuántos minutos le toma llegar al trabajo?"),
                    value = NULL,
                    min = 0, max = 500, step = 1 
                )
            ),

            formInput(
                my_title = "Pregunta 12",
                selectInput(
                    inputId = "cuida_hijos",
                    label = question("¿Quién cuida a sus hij@s cuando está trabajando?"),
                    choices = c("Yo", parentesco),
                    multiple = FALSE,
                    selected = NULL
                )
            ),

            formInput(
                my_title = "Pregunta 13",
                numericInput(
                    inputId = "asistencia_escolar",
                    label = question("¿Cuántas personas asisten a la escuela?"),
                    value = NULL,
                    min = 0, max = 50, step = 1 
                )
            ),

            formInput(
                my_title = "Pregunta 14",
                numericInput(
                    inputId = "cantidad_hijas",
                    label = question("¿Cuántas hijas tiene?"),
                    value = NULL,
                    min = 0, max = 50, step = 1 
                )
            ),

            formInput(
                my_title = "Pregunta 15",
                numericInput(
                    inputId = "cantidad_hijos",
                    label = question("¿Cuántos hijos tiene?"),
                    value = NULL,
                    min = 0, max = 50, step = 1 
                )
            ),

            formInput(
                my_title = "Pregunta 16",
                selectInput(
                    inputId = "rango_edad_hijos",
                    label = question("Rango de edad de sus hijos e hijas"),
                    choices = rangos_edad_hijos,
                    multiple = TRUE,
                    selected = NULL
                )
            ),

            formInput(
                my_title = "Pregunta 17",
                selectInput(
                    inputId = "servicio_medico",
                    label = question("¿A qué servicio médico pertenece?"),
                    choices = servicios_medicos,
                    multiple = FALSE,
                    selected = NULL
                )
            ),

            formInput(
                my_title = "Pregunta 18",
                selectInput(
                    inputId = "supermanzana_vivienda",
                    label = question("¿En qué supermanzana vive actualmente?"),
                    choices = listado_supermanzanas,
                    multiple = FALSE,
                    selected = NULL
                )
            ),

            formInput(
                my_title = "Pregunta 19",
                selectInput(
                    inputId = "ultimo_grado_estudios",
                    label = question("¿Cuál es el ultimo grado de estudios del principal ingreso económico del hogar?"),
                    choices = grados_estudios,
                    multiple = FALSE,
                    selected = NULL
                )
            ),

            formInput(
                my_title = "Pregunta 20",
                selectInput(
                    inputId = "ultimo_grado_estudios",
                    label = question("¿Cuáles son las 3 principales necesidades (en orden de importancia) de su familia?"),
                    choices = principales_necesidades,
                    multiple = TRUE,
                    selected = NULL
                )
            ),

            formInput(
                my_title = "Pregunta 21",
                radioButtons(
                    inputId = "conoce_ciam",
                    label = question("¿Conoce el CIAM?"),
                    choices = c("Sí lo conozco", "No lo conozco")
                )
            ),

            formInput(
                my_title = "Pregunta 22",
                textAreaInput(
                    inputId = "actividades_recomendadas",
                    label = question("¿Qué actividades/servicios adicionales te gustaría que el CIAM ofreciera?"),
                    placeholder = "Nos ayudarás mucho con tus comentarios",
                    resize = "vertical"

                )
            ),

            # Preguntas si la persona que responde el cuestionario
            # no es el principal ingreso económico

            formInput(
                my_title = "Pregunta 23",
                selectInput(
                    inputId = "ultimo_grado_estudios_encuestado",
                    label = question("¿Cuál es tu ultimo grado de estudios?"),
                    choices = grados_estudios,
                    multiple = FALSE,
                    selected = NULL
                )
            ),

            formInput(
                my_title = "Pregunta 24",
                radioButtons(
                    inputId = "sabe_leer_escribir",
                    label = question("¿Sabes leer y/o escribir?"),
                    choices = c("Sí", "No")
                )
            ),

            formInput(
                my_title = "Pregunta 25",
                radioButtons(
                    inputId = "habla_lengua_indigena",
                    label = question("¿Hablas alguna lengua indigena?"),
                    choices = c("Sí", "No")
                )
            )
        )
    )
)

footer <- dashboardFooter(left = HTML("<b>CIAM Cancún</b> &copy; Empoderando a las mujeres <i class='fa-solid fa-heart fa-beat' style='color: purple'></i>"))

ui <- dashboardPage(header = header, sidebar = sidebar, body =  body, footer = footer)

server <- function(input, output, session) {
}

options(shiny.autoreload = TRUE)
shinyApp(ui, server)