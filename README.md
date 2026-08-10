# Scout da Pelada — Supabase

Esta versão usa o Supabase como banco online.

## Passo 1 — importar os saldos históricos
No Supabase > SQL Editor, abra uma nova consulta e execute todo o arquivo `importar_saldos_historicos.sql`.
O comando adiciona `titulos_iniciais`, preserva as 22 rodadas existentes e preenche gols, assistências e títulos históricos.

## Passo 2 — publicar o app
Substitua os arquivos do mesmo repositório GitHub conectado à Vercel e faça Commit.
Os links de produção permanecem os mesmos.

## Como os totais funcionam
- Gols = saldo histórico + gols lançados nas rodadas pelo ADM.
- Assistências = saldo histórico + assistências lançadas nas rodadas pelo ADM.
- Títulos = saldo histórico + rodadas futuras marcadas como campeão pelo ADM.
- Rodadas = quantidade real de participações em `scouts`.

Observação: os scouts antigos de gols/assistências não tinham data individual na planilha original, por isso ficam como saldo histórico e não são distribuídos artificialmente entre os sábados.
