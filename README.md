# Scout da Pelada - Supabase + Vercel

Esta versao salva os dados online no Supabase.

## Antes de publicar
1. No Supabase > SQL Editor, execute todo o arquivo `supabase_setup_final.sql` uma vez.
2. O resultado final deve mostrar `admin_configurado = true` quando executado enquanto voce esta no SQL Editor (o teste pode aparecer false porque o SQL Editor usa papel postgres; isso nao impede o cadastro do admin). Para conferir o cadastro: `select * from app_admins;` deve retornar 1 linha.

## Publicar na Vercel
Substitua os arquivos do repositorio atual pelos arquivos desta pasta e faca Commit. Se o mesmo repositorio continuar conectado a Vercel, os links permanecem os mesmos.

- Publico: `/`
- ADM: `/admin.html`

## Funcionamento
- Publico: somente leitura.
- ADM: login por e-mail e senha do Supabase Authentication.
- Alteracoes sao gravadas no Supabase e compartilhadas com todos.
- A pagina publica atualiza os dados automaticamente a cada 30 segundos e ao voltar para a aba.

Nunca coloque uma `sb_secret_...` no projeto. O arquivo `config.js` usa apenas a chave publishable.
