-- Pelada League - Foto dos Campeoes da Semana
-- Execute UMA VEZ no SQL Editor do Supabase.
-- Nao apaga nenhum dado existente.

begin;

alter table public.rodadas
  add column if not exists foto_campeoes_path text;

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'campeoes-semana',
  'campeoes-semana',
  true,
  8388608,
  array['image/jpeg','image/png','image/webp']
)
on conflict (id) do update
set public = excluded.public,
    file_size_limit = excluded.file_size_limit,
    allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "admin_envia_foto_campeoes" on storage.objects;
create policy "admin_envia_foto_campeoes"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'campeoes-semana'
  and public.is_app_admin()
);

drop policy if exists "admin_atualiza_foto_campeoes" on storage.objects;
create policy "admin_atualiza_foto_campeoes"
on storage.objects for update
to authenticated
using (
  bucket_id = 'campeoes-semana'
  and public.is_app_admin()
)
with check (
  bucket_id = 'campeoes-semana'
  and public.is_app_admin()
);

drop policy if exists "admin_exclui_foto_campeoes" on storage.objects;
create policy "admin_exclui_foto_campeoes"
on storage.objects for delete
to authenticated
using (
  bucket_id = 'campeoes-semana'
  and public.is_app_admin()
);

commit;

select 'ok' as foto_campeoes_configurada;
