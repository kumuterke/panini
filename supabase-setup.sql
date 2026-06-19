-- Run in Supabase SQL Editor.
create extension if not exists pgcrypto;

create table if not exists public.stickers (
  id uuid primary key default gen_random_uuid(),
  team text not null check (char_length(team) between 2 and 4),
  team_name text not null,
  number integer not null check (number > 0),
  quantity integer not null default 1 check (quantity > 0),
  image_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(team, number)
);

alter table public.stickers enable row level security;

drop policy if exists "Public can read stickers" on public.stickers;
create policy "Public can read stickers"
on public.stickers for select
to anon, authenticated
using (true);

-- Replace the UUID below with your own Supabase Auth user UUID.
-- Dashboard: Authentication > Users > your user > copy User UID.
drop policy if exists "Only admin can insert stickers" on public.stickers;
create policy "Only admin can insert stickers"
on public.stickers for insert
to authenticated
with check ((select auth.uid()) = 'YOUR_ADMIN_USER_UUID'::uuid);

drop policy if exists "Only admin can update stickers" on public.stickers;
create policy "Only admin can update stickers"
on public.stickers for update
to authenticated
using ((select auth.uid()) = 'YOUR_ADMIN_USER_UUID'::uuid)
with check ((select auth.uid()) = 'YOUR_ADMIN_USER_UUID'::uuid);

drop policy if exists "Only admin can delete stickers" on public.stickers;
create policy "Only admin can delete stickers"
on public.stickers for delete
to authenticated
using ((select auth.uid()) = 'YOUR_ADMIN_USER_UUID'::uuid);

grant select on public.stickers to anon;
grant select, insert, update, delete on public.stickers to authenticated;

insert into public.stickers(team,team_name,number,quantity,image_url) values
('TUN','Tunus',7,1,NULL),
('TUN','Tunus',6,1,NULL),
('TUN','Tunus',13,1,NULL),
('TUN','Tunus',4,1,NULL),
('TUN','Tunus',5,1,NULL),
('SWE','İsveç',11,1,NULL),
('SWE','İsveç',15,1,NULL),
('SWE','İsveç',1,1,NULL),
('SWE','İsveç',18,1,NULL),
('NED','Hollanda',9,1,NULL),
('NED','Hollanda',18,1,NULL),
('NED','Hollanda',12,1,NULL),
('NED','Hollanda',17,1,NULL),
('NED','Hollanda',2,1,NULL),
('JPN','Japonya',6,1,NULL),
('JPN','Japonya',10,1,NULL),
('JPN','Japonya',17,1,NULL),
('JPN','Japonya',19,1,NULL),
('JPN','Japonya',8,1,NULL),
('ECU','Ekvador',3,1,NULL),
('CIV','Fildişi Sahili',6,2,NULL),
('CIV','Fildişi Sahili',17,1,NULL),
('GER','Almanya',16,1,NULL),
('GER','Almanya',20,1,NULL),
('GER','Almanya',7,1,NULL),
('AUS','Avustralya',8,1,NULL),
('AUS','Avustralya',13,1,NULL),
('PAR','Paraguay',3,1,NULL),
('HAI','Haiti',17,1,NULL),
('HAI','Haiti',6,1,NULL),
('HAI','Haiti',8,1,NULL),
('HAI','Haiti',11,1,NULL),
('MOR','Fas',19,1,NULL),
('MOR','Fas',2,1,NULL),
('MOR','Fas',3,1,NULL),
('MOR','Fas',7,1,NULL),
('BRA','Brezilya',3,1,NULL),
('BRA','Brezilya',2,1,NULL),
('QAT','Katar',8,1,NULL),
('QAT','Katar',12,1,NULL),
('QAT','Katar',3,1,NULL),
('QAT','Katar',4,1,NULL),
('QAT','Katar',16,1,NULL),
('CAN','Kanada',5,1,NULL),
('KOR','Güney Kore',15,1,NULL),
('KOR','Güney Kore',13,1,NULL),
('KOR','Güney Kore',19,1,NULL),
('RSA','Güney Afrika',10,1,NULL),
('RSA','Güney Afrika',17,1,NULL),
('RSA','Güney Afrika',7,1,NULL),
('RSA','Güney Afrika',18,1,NULL),
('MEX','Meksika',5,1,NULL),
('MEX','Meksika',11,1,NULL),
('MEX','Meksika',2,1,NULL),
('MEX','Meksika',3,1,NULL),
('BEL','Belçika',19,1,NULL),
('BEL','Belçika',18,1,NULL),
('BEL','Belçika',9,1,NULL),
('EGY','Mısır',15,1,NULL),
('EGY','Mısır',13,1,NULL),
('IRN','İran',13,1,NULL),
('URU','Uruguay',11,1,NULL),
('URU','Uruguay',13,1,NULL),
('AUT','Avusturya',1,1,NULL),
('AUT','Avusturya',4,1,NULL),
('NOR','Norveç',5,1,NULL),
('NOR','Norveç',19,1,NULL),
('POR','Portekiz',1,1,NULL),
('POR','Portekiz',9,1,NULL),
('SEN','Senegal',12,1,NULL),
('SEN','Senegal',17,1,NULL),
('COL','Kolombiya',5,1,NULL),
('COL','Kolombiya',8,1,NULL),
('ENG','İngiltere',9,1,NULL),
('ENG','İngiltere',2,1,NULL),
('CRO','Hırvatistan',3,1,NULL),
('CRO','Hırvatistan',15,1,NULL),
('PAN','Panama',4,1,NULL),
('PAN','Panama',8,1,NULL),
('FWC','FIFA World Cup',10,1,NULL),
('ESP','İspanya',8,1,NULL),
('JOR','Ürdün',3,1,NULL),
('IRQ','Irak',7,1,NULL),
('USA','ABD',17,1,NULL)
on conflict (team,number) do update
set team_name=excluded.team_name, quantity=excluded.quantity;
