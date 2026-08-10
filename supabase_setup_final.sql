-- Scout da Pelada - seguranca final do Supabase
-- Execute UMA VEZ no SQL Editor antes de usar o novo ADM.

begin;

-- Tabela interna de administradores.
create table if not exists public.app_admins (
  user_id uuid primary key references auth.users(id) on delete cascade,
  criado_em timestamptz not null default now()
);

-- Como neste momento existe apenas o seu usuario, cadastra o primeiro usuario criado como admin.
insert into public.app_admins (user_id)
select id from auth.users order by created_at asc limit 1
on conflict (user_id) do nothing;

alter table public.app_admins enable row level security;

-- Funcao segura usada pelas politicas sem expor a lista de administradores.
create or replace function public.is_app_admin()
returns boolean
language sql
stable
security definer
set search_path = public, auth
as $$
  select exists (
    select 1 from public.app_admins a where a.user_id = auth.uid()
  );
$$;

grant execute on function public.is_app_admin() to authenticated;

-- Permissoes SQL basicas.
grant select on public.jogadores, public.rodadas, public.scouts to anon, authenticated;
grant insert, update, delete on public.jogadores, public.rodadas, public.scouts to authenticated;
grant usage, select on all sequences in schema public to authenticated;

-- Remove as politicas amplas criadas anteriormente.
drop policy if exists "admin_insere_jogadores" on public.jogadores;
drop policy if exists "admin_edita_jogadores" on public.jogadores;
drop policy if exists "admin_exclui_jogadores" on public.jogadores;
drop policy if exists "admin_insere_rodadas" on public.rodadas;
drop policy if exists "admin_edita_rodadas" on public.rodadas;
drop policy if exists "admin_exclui_rodadas" on public.rodadas;
drop policy if exists "admin_insere_scouts" on public.scouts;
drop policy if exists "admin_edita_scouts" on public.scouts;
drop policy if exists "admin_exclui_scouts" on public.scouts;

-- Usuario autenticado tambem precisa conseguir ler os dados no ADM.
drop policy if exists "autenticado_le_jogadores" on public.jogadores;
create policy "autenticado_le_jogadores" on public.jogadores
for select to authenticated using (true);

drop policy if exists "autenticado_le_rodadas" on public.rodadas;
create policy "autenticado_le_rodadas" on public.rodadas
for select to authenticated using (true);

drop policy if exists "autenticado_le_scouts" on public.scouts;
create policy "autenticado_le_scouts" on public.scouts
for select to authenticated using (true);

-- Escrita: somente usuario cadastrado em app_admins.
drop policy if exists "somente_admin_insere_jogadores" on public.jogadores;
create policy "somente_admin_insere_jogadores" on public.jogadores
for insert to authenticated with check (public.is_app_admin());

drop policy if exists "somente_admin_edita_jogadores" on public.jogadores;
create policy "somente_admin_edita_jogadores" on public.jogadores
for update to authenticated using (public.is_app_admin()) with check (public.is_app_admin());

drop policy if exists "somente_admin_exclui_jogadores" on public.jogadores;
create policy "somente_admin_exclui_jogadores" on public.jogadores
for delete to authenticated using (public.is_app_admin());

drop policy if exists "somente_admin_insere_rodadas" on public.rodadas;
create policy "somente_admin_insere_rodadas" on public.rodadas
for insert to authenticated with check (public.is_app_admin());

drop policy if exists "somente_admin_edita_rodadas" on public.rodadas;
create policy "somente_admin_edita_rodadas" on public.rodadas
for update to authenticated using (public.is_app_admin()) with check (public.is_app_admin());

drop policy if exists "somente_admin_exclui_rodadas" on public.rodadas;
create policy "somente_admin_exclui_rodadas" on public.rodadas
for delete to authenticated using (public.is_app_admin());

drop policy if exists "somente_admin_insere_scouts" on public.scouts;
create policy "somente_admin_insere_scouts" on public.scouts
for insert to authenticated with check (public.is_app_admin());

drop policy if exists "somente_admin_edita_scouts" on public.scouts;
create policy "somente_admin_edita_scouts" on public.scouts
for update to authenticated using (public.is_app_admin()) with check (public.is_app_admin());

drop policy if exists "somente_admin_exclui_scouts" on public.scouts;
create policy "somente_admin_exclui_scouts" on public.scouts
for delete to authenticated using (public.is_app_admin());

commit;

select public.is_app_admin() as admin_configurado;
