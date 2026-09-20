-- THD Visit run sheet: schema on Supabase project ryobi-orgchart-app (ref hivklrirmsxkpjozoqwd)
-- Already applied. Keep for reference or to rebuild in another project.
create table if not exists public.thd_records(
  collection text not null check (collection in ('events','people','cars','venues','restaurants')),
  id text not null,
  data jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (collection,id)
);
alter table public.thd_records enable row level security;
drop policy if exists thd_records_read on public.thd_records;
create policy thd_records_read on public.thd_records for select to anon, authenticated using (true);
revoke insert, update, delete, truncate on public.thd_records from anon, authenticated;
grant select on public.thd_records to anon, authenticated;

create table if not exists public.thd_settings(key text primary key, value text not null);
alter table public.thd_settings enable row level security;
revoke all on public.thd_settings from anon, authenticated;

create or replace function public.thd_check_token(p_token text) returns boolean
language sql stable security definer set search_path = '' as $$
  select exists(select 1 from public.thd_settings s
    where s.key='edit_token_sha256' and s.value=encode(extensions.digest(coalesce(p_token,''),'sha256'),'hex'));
$$;

create or replace function public.thd_save(p_token text, p_collection text, p_id text, p_data jsonb) returns void
language plpgsql security definer set search_path = '' as $$
begin
  if not public.thd_check_token(p_token) then raise exception 'not allowed' using errcode = '42501'; end if;
  if p_id is null or length(p_id)=0 or length(p_id)>200 then raise exception 'bad id'; end if;
  if pg_column_size(p_data) > 200000 then raise exception 'too large'; end if;
  insert into public.thd_records(collection,id,data,updated_at) values (p_collection,p_id,p_data,now())
  on conflict (collection,id) do update set data=excluded.data, updated_at=now();
end $$;

revoke all on function public.thd_save(text,text,text,jsonb) from public;
revoke all on function public.thd_check_token(text) from public;
grant execute on function public.thd_save(text,text,text,jsonb) to anon, authenticated;
grant execute on function public.thd_check_token(text) to anon, authenticated;

do $$ begin
  if not exists (select 1 from pg_publication_tables where pubname='supabase_realtime' and schemaname='public' and tablename='thd_records') then
    alter publication supabase_realtime add table public.thd_records;
  end if;
end $$;
