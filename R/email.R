library(gmailr)

gmailr::gm_auth_configure(

)
gmailr::gm_auth(

)

send_email <- function(nome = NULL, matricula = NULL, data = NULL, hora = NULL, local = NULL, tipo = "COMP") {
  
  email <-
  switch(
    tipo,
    'COMP' =  {
        list(
          subject = paste0("COMPLEMENTAÇÃO: ", nome,  " (matrícula Nº ", matricula, ")"),
          body = paste0("A prova de complementação do discente ", nome, " (matrícula Nº ",
                matricula, ") será realizada em ", data, ", às ", hora, ", na(o) ", local, "."),
          pdf = "parecer/enviar_email/despacho_complementacao.pdf"
        )
    }, 
    
    'DE' = {
      list(
        subject = paste0("DEFERIDO: ", nome,  " (matrícula Nº ", matricula, ")"),
        body = paste0("A solicitação do discente ", nome, " (matrícula Nº ",
                       matricula, ") foi DEFERIDA em ", format(Sys.Date(), "%d/%m/%Y")),
        pdf = "parecer/enviar_email/despacho_deferido.pdf"
      )
    },
    
    'IND' = {
      list(
        subject = paste0("INDEFERIDO: ", nome,  " (matrícula Nº ", matricula, ")"),
        body = paste0("A solicitação do discente ", nome, " (matrícula Nº ",
                      matricula, ") foi INDEFERIDA em ", format(Sys.Date(), "%d/%m/%Y"), "."),
        pdf = "parecer/enviar_email/despacho_indeferido.pdf"
      )
    },
    
    'DESP' = {
      list(
        subject = paste0("DESPACHO"),
        body = paste0("Despacho redigido em ", format(Sys.Date(), "%d/%m/%Y"), "."),
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

