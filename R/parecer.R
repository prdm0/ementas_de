parecer_def <- downloadHandler(
  filename = "parecer_final_deferido.pdf",
  content = function(file) {
    rmarkdown::render(
      "parecer/modelos/modelo_deferido.Rmd",
      output_file = file,
      params = list(nome = input$nomeDE, matricula = input$matriculaDE),
      envir = new.env(parent = globalenv())
    )
  }
)