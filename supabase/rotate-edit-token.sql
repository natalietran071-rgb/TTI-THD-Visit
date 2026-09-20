-- Change the admin edit code. Replace NEW_CODE (letters/digits, 16+ chars), run in Supabase SQL editor,
-- then share the new admin link: https://<pages-url>/#edit=NEW_CODE
insert into public.thd_settings(key,value)
values ('edit_token_sha256', encode(extensions.digest('NEW_CODE','sha256'),'hex'))
on conflict (key) do update set value = excluded.value;
