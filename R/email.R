gmailr::gm_auth_configure(
  key = "1070614989941-l7k...",
  secret = "GOCSPX-wp..."
)
gmailr::gm_auth(
  email = "comissao.dispensa.estatistica@gmail.com",
  token = "4/1AX4Xf...",
  path = "client_secret...",
  cache=".secrets"
)

send_email <- function(nome = NULL, matricula = NULL, data = NULL, hora = NULL, local = NULL, tipo = "COMP") {
  
  email <-
  switch(
    tipo,
    'COMP' =  {
        list(
          subject = glue("COMPLEMENTAÇÃO: {substr(nome, 1L, 15L)} (Nº {matricula})"),
          body = glue("A prova de complementação do discente {nome} (matrícula Nº {matricula}) será realizada em {format(Sys.Date(), '%d/%m/%Y')}, no(a) {local}."),
          pdf = glue("parecer/enviar_email/despacho_complementacao_{nome}_{matricula}.pdf")
        )
    }, 
    
    'DE' = {
      list(
        subject = glue("DEFERIDO: {substr(nome, 1L, 15L)} (Nº {matricula})"),
        body = glue("A solicitação do discente {nome} (matrícula Nº {matricula}) foi DEFERIDA em {format(Sys.Date(), '%d/%m/%Y')}."),
        pdf = glue("parecer/enviar_email/despacho_deferido_{nome}_{matricula}.pdf")
      )
    },
    
    'IND' = {
      list(
        subject = glue("INDEFERIDO: {substr(nome, 1L, 15L)} (Nº {matricula})"),
        body = glue("A solicitação do discente {nome} (matrícula Nº {matricula}) foi INDEFERIDA em {format(Sys.Date(), '%d/%m/%Y')}."),
        pdf = glue("parecer/enviar_email/despacho_indeferido_{nome}_{matricula}.pdf")
      )
    },
    
    'DESP' = {
      list(
        subject = glue("DESPACHO"),
        body =  glue("Despacho redigido em um modelo específico no dia {format(Sys.Date(), '%d/%m/%Y')}"),
        pdf = "parecer/enviar_email/despacho.pdf"
      )
    }
  )
  
  test_email <-
    gm_mime() |>
    gm_to("comissao.dispensa.estatistica@gmail.com") |>
    gm_from("comissao.dispensa.estatistica@gmail.com") |>
    gm_subject(email$subject) |>
    gm_text_body(email$body) |>
    gm_attach_file(email$pdf)
  
  # Verify it looks correct
  gm_create_draft(test_email, user_id = "me")
  
  # If all is good with your draft, then you can send it
  gm_send_message(test_email)
  
  # gm_deauth()
}

