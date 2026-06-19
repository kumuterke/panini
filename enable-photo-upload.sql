-- Run this ONCE in Supabase SQL Editor.
-- Creates a public image bucket, but only your admin account can upload/change/delete files.

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'sticker-images',
  'sticker-images',
  true,
  5242880,
  array['image/jpeg','image/png','image/webp']
)
on conflict (id) do update set
  public = excluded.public,
  file_size_limit = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "Admin uploads sticker images" on storage.objects;
create policy "Admin uploads sticker images"
on storage.objects
for insert
to authenticated
with check (
  bucket_id = 'sticker-images'
  and (select auth.uid()) = 'bb70b256-b341-4244-bc4e-8787a8bb497d'::uuid
);

drop policy if exists "Admin updates sticker images" on storage.objects;
create policy "Admin updates sticker images"
on storage.objects
for update
to authenticated
using (
  bucket_id = 'sticker-images'
  and (select auth.uid()) = 'bb70b256-b341-4244-bc4e-8787a8bb497d'::uuid
)
with check (
  bucket_id = 'sticker-images'
  and (select auth.uid()) = 'bb70b256-b341-4244-bc4e-8787a8bb497d'::uuid
);

drop policy if exists "Admin deletes sticker images" on storage.objects;
create policy "Admin deletes sticker images"
on storage.objects
for delete
to authenticated
using (
  bucket_id = 'sticker-images'
  and (select auth.uid()) = 'bb70b256-b341-4244-bc4e-8787a8bb497d'::uuid
);

-- Public bucket files can be viewed by visitors through their public URLs.
