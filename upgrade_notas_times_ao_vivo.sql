-- Execute uma vez no Supabase SQL Editor

alter table public.jogadores
  add column if not exists nota numeric(3,1) not null default 5;

alter table public.scouts
  add column if not exists time_nome text;

-- Limita notas futuras ao intervalo de 0 a 10.
do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'jogadores_nota_intervalo'
  ) then
    alter table public.jogadores
      add constraint jogadores_nota_intervalo check (nota >= 0 and nota <= 10);
  end if;
end $$;

select 'ok' as configuracao, count(*) as jogadores from public.jogadores;
