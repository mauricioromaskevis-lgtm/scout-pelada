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

## Atualizacao - historico detalhado de rodadas
- O historico mostra cada participante da rodada com gols, assistencias e indicador de campeao.
- Rodadas existentes podem ser abertas em "Editar rodada", corrigidas e salvas novamente.
- Rodadas podem ser excluidas pelo ADM.
- A busca de jogadores durante o lancamento de uma rodada preserva todas as selecoes, gols, assistencias e campeoes ja marcados enquanto novas pesquisas sao feitas.
- Nao e necessario executar SQL adicional para esta atualizacao.


## Versao notas, times e ao vivo
Antes de publicar esta versao, execute `upgrade_notas_times_ao_vivo.sql` uma vez no SQL Editor do Supabase. Depois substitua os arquivos no mesmo repositorio da Vercel.

Novidades: nota de 0 a 10 por jogador, selecao persistente com busca, sorteio equilibrado de 2 a 4 times, times salvos na rodada e modo Pelada ao vivo para atualizar gols, assistencias e campeoes imediatamente.
