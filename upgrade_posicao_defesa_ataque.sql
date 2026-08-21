-- Posicao do jogador: Defesa ou Ataque
alter table public.jogadores
  add column if not exists posicao text;

-- Aproveita a classificacao anterior: quem estava marcado como defesa vira Defesa;
-- os demais passam a ser Ataque.
update public.jogadores
set posicao = case when coalesce(defesa,false) then 'defesa' else 'ataque' end
where posicao is null;

alter table public.jogadores
  alter column posicao set default 'ataque';

alter table public.jogadores
  alter column posicao set not null;

do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'jogadores_posicao_check'
  ) then
    alter table public.jogadores
      add constraint jogadores_posicao_check
      check (posicao in ('defesa','ataque'));
  end if;
end $$;

select nome, nota, posicao, velocidade
from public.jogadores
order by nome;
