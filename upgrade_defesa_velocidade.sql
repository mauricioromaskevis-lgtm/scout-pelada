-- Novos atributos dos jogadores
alter table public.jogadores
  add column if not exists defesa boolean not null default false;

alter table public.jogadores
  add column if not exists velocidade text;

-- Mantem somente os valores usados pelo app, mas permite NULL para quem ainda nao foi classificado.
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'jogadores_velocidade_check'
  ) then
    alter table public.jogadores
      add constraint jogadores_velocidade_check
      check (velocidade is null or velocidade in ('rapido','lento'));
  end if;
end $$;

select nome, nota, defesa, velocidade
from public.jogadores
order by nome;
