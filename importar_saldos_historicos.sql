-- IMPORTA SALDOS HISTORICOS DE GOLS, ASSISTENCIAS E TITULOS
-- Seguro para executar novamente: os valores sao definidos, nao somados.
begin;

alter table public.jogadores add column if not exists titulos_iniciais integer not null default 0;

-- Garante que jogadores do historico que nao apareceram nas 22 rodadas tambem existam.
with dados(nome) as (values
  ('Andrei'),
  ('Arthur'),
  ('Baró'),
  ('Bruno'),
  ('Bruno C'),
  ('Caldas'),
  ('Carioca'),
  ('Davi'),
  ('Dedé'),
  ('Eduardo'),
  ('Eduardo Edesio'),
  ('Fabio GK'),
  ('Felipe Melo'),
  ('Feliphe'),
  ('Firmino'),
  ('Fumaça'),
  ('Geladeira'),
  ('Joao goleiro'),
  ('JP'),
  ('Juninho'),
  ('Kerllon'),
  ('Kikinho'),
  ('Luis'),
  ('Manuel Goleiro'),
  ('Marco - Eduardo'),
  ('Marcos'),
  ('Marcos Cirilo'),
  ('Markin'),
  ('Matheus - Edu'),
  ('Matheus F'),
  ('Maurício'),
  ('Max'),
  ('Moura'),
  ('Mtz'),
  ('Nanan'),
  ('Pará'),
  ('Pastor'),
  ('Patrick'),
  ('Paulista'),
  ('Pedro C'),
  ('Pedrão'),
  ('Rique'),
  ('Rod'),
  ('Rodrigo Goleiro'),
  ('Rossi'),
  ('Salinas'),
  ('Samuel'),
  ('Temponi'),
  ('Vilas Boas'),
  ('Manaus'),
  ('Pedro Viana'),
  ('Victor'),
  ('Vinicius'),
  ('Vítor Asafe')
)
insert into public.jogadores (nome, ativo, gols_iniciais, assistencias_iniciais, titulos_iniciais)
select d.nome, true, 0, 0, 0 from dados d
where not exists (select 1 from public.jogadores j where lower(trim(j.nome))=lower(trim(d.nome)));

-- Aplica o saldo historico vindo da planilha.
with dados(nome,gols,assistencias,titulos) as (values
  ('Andrei', 15, 14, 4),
  ('Arthur', 0, 1, 0),
  ('Baró', 30, 13, 3),
  ('Bruno', 1, 0, 0),
  ('Bruno C', 0, 5, 0),
  ('Caldas', 27, 20, 4),
  ('Carioca', 11, 8, 1),
  ('Davi', 11, 9, 1),
  ('Dedé', 27, 24, 7),
  ('Eduardo', 32, 13, 3),
  ('Eduardo Edesio', 2, 0, 0),
  ('Fabio GK', 5, 0, 0),
  ('Felipe Melo', 0, 1, 0),
  ('Feliphe', 12, 4, 0),
  ('Firmino', 0, 0, 1),
  ('Fumaça', 3, 1, 1),
  ('Geladeira', 26, 28, 2),
  ('Joao goleiro', 1, 1, 0),
  ('JP', 15, 11, 2),
  ('Juninho', 1, 0, 0),
  ('Kerllon', 4, 3, 1),
  ('Kikinho', 8, 1, 0),
  ('Luis', 5, 1, 1),
  ('Manuel Goleiro', 0, 3, 0),
  ('Marco - Eduardo', 5, 1, 1),
  ('Marcos', 5, 2, 2),
  ('Marcos Cirilo', 3, 2, 1),
  ('Markin', 1, 2, 1),
  ('Matheus - Edu', 3, 1, 0),
  ('Matheus F', 4, 0, 0),
  ('Maurício', 25, 16, 3),
  ('Max', 11, 8, 2),
  ('Moura', 33, 18, 2),
  ('Mtz', 6, 2, 2),
  ('Nanan', 14, 3, 3),
  ('Pará', 8, 2, 0),
  ('Pastor', 25, 16, 4),
  ('Patrick', 11, 5, 0),
  ('Paulista', 0, 1, 0),
  ('Pedro C', 6, 4, 2),
  ('Pedrão', 0, 0, 1),
  ('Rique', 3, 3, 0),
  ('Rod', 1, 0, 0),
  ('Rodrigo Goleiro', 5, 0, 0),
  ('Rossi', 21, 17, 4),
  ('Salinas', 29, 17, 4),
  ('Samuel', 0, 2, 0),
  ('Temponi', 32, 13, 6),
  ('Vilas Boas', 15, 11, 2),
  ('Manaus', 9, 6, 1),
  ('Pedro Viana', 1, 0, 0),
  ('Victor', 11, 7, 4),
  ('Vinicius', 4, 1, 1),
  ('Vítor Asafe', 0, 1, 1)
)
update public.jogadores j
set gols_iniciais=d.gols, assistencias_iniciais=d.assistencias, titulos_iniciais=d.titulos
from dados d
where lower(trim(j.nome))=lower(trim(d.nome));

commit;

-- CONFERENCIA
select j.nome,
       j.gols_iniciais as gols_historicos,
       j.assistencias_iniciais as assistencias_historicas,
       j.titulos_iniciais as titulos_historicos,
       count(s.id) as rodadas
from public.jogadores j
left join public.scouts s on s.jogador_id=j.id
group by j.id,j.nome,j.gols_iniciais,j.assistencias_iniciais,j.titulos_iniciais
order by j.gols_iniciais desc, j.nome;