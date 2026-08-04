# Scout da Pelada

Aplicativo web responsivo para registrar os scouts da pelada de sabado.

## Recursos

- Historico importado da planilha original
- Cadastro de rodadas
- Gols, assistencias e campeoes
- Ranking acumulado
- Cadastro e inativacao de jogadores
- Exportacao e importacao de backup
- Instalacao no celular como PWA

## Publicar pela interface da Vercel

1. Extraia o arquivo ZIP.
2. Envie a pasta para um repositorio no GitHub, GitLab ou Bitbucket.
3. Na Vercel, clique em **Add New > Project**.
4. Importe o repositorio.
5. Em **Framework Preset**, selecione **Other** caso a deteccao automatica nao escolha um framework.
6. Nao preencha Build Command.
7. Use `.` como Output Directory, caso o painel exija um valor.
8. Clique em **Deploy**.

## Publicar pela linha de comando

```bash
npm install -g vercel
cd scout-pelada-vercel
vercel --prod
```

## Armazenamento dos dados

A versao atual salva os novos dados no `localStorage` do navegador. Isso significa que cada aparelho possui sua propria base. Use **Exportar backup** regularmente.

Para sincronizar varios celulares na mesma base, sera necessario conectar o aplicativo a um banco online, como Supabase, Firebase ou Vercel Postgres.
