library(gmailr)

# Autentique aqui

send_email <- function(nome, matricula, data, hora, local) {

  test_email <-
    gm_mime() |>
    gm_to("comissao.dispensa.estatistica@gmail.com") |>
    gm_from("comissao.dispensa.estatistica@gmail.com") |>
    gm_subject(paste0("Complementação: ", nome,  " matrícula Nº ", matricula)) |>
    gm_text_body(
        paste0("Prova de complementação do discente ", nome, " matrícula Nº ", matricula, " para ser realizada em ", data, " as ",  "hora ", "na(o) ", local,".")
    ) |>
    gm_attach_file("parecer/enviar_email/despacho_complementacao.pdf")
  
  # Verify it looks correct
  gm_create_draft(test_email, user_id = "me")
  
  # If all is good with your draft, then you can send it
  gm_send_message(test_email)
  
  # gm_deauth()
}

