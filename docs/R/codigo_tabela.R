library(DT)
library(vroom)
library(stringr)
library(dplyr)

ementas <- vroom::vroom("data/banco_dados_ementas.csv", 
                        progress = FALSE, show_col_types = FALSE)


bacharelado_servico <- function(x, serv = TRUE){
  x |>
    dplyr::filter(servico == serv) |>
    dplyr::select(-servico) |>
    dplyr::rename(
      c(
        Código = codigo,
        Assuntos = ementa,
        Disciplina = nome_disciplina,
        Abreviação = nome_abreviado,
        Horas = horas,
        Créditos = creditos
      )
    )
}

disciplinas_de <- bacharelado_servico(ementas, serv = FALSE)
disciplinas_servico <- bacharelado_servico(ementas, serv = TRUE)

tabela <- function(x){
  x |> 
  DT::datatable(
    editable = FALSE,
    options = list(
      pageLength = 10,
      lengthMenu = c(5, 10, 15, 20),
      paging = TRUE,    ## paginate the output
      buttons = c('pdf', 'excel', 'csv', 'print'),
      dom = 'Bfrtip',
      scrollY = TRUE,
      scrollX = TRUE,
      language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Portuguese-Brasil.json')
    ),
    extensions = 'Buttons',
    selection = 'single', ## enable selection of a single row
    rownames = TRUE,                ## don't show row numbers/names
    caption = 'BANCO DE DADOS DAS DISCIPLINAS FORNECIDAS PELO DEPARTAMENTO DE ESTATÍSTICA - UFPB.'
  )
}

search_all <- function(data, text){
  x <-
    data |>
    filter_all(any_vars(str_detect(., regex(text, ignore_case = TRUE))))
  
  list(
    Código = x$Código[1L],
    Disciplina = x$Disciplina[1L],
    Assuntos = x$Assuntos,
    Horas = x$Horas[1L],
    Créditos = x$Créditos[1L]
  )
}

