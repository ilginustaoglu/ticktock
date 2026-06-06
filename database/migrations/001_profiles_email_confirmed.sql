-- Mevcut Supabase projesine çalıştır: profiles tablosuna e-posta onay takibi
-- Supabase SQL Editor → New query → Run

alter table public.profiles
  add column if not exists email text,
  add column if not exists email_confirmed_at timestamptz;

-- Mevcut kullanıcıları auth.users ile eşitle
update public.profiles p
set
  email = u.email,
  email_confirmed_at = u.email_confirmed_at
from auth.users u
where p.id = u.id;

-- Yeni kayıt trigger'ını güncelle
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email, first_name, last_name, email_confirmed_at)
  values (
    new.id,
    new.email,
    coalesce(new.raw_user_meta_data ->> 'first_name', ''),
    coalesce(new.raw_user_meta_data ->> 'last_name', ''),
    new.email_confirmed_at
  );
  return new;
end;
$$;

-- Onay / e-posta değişince profiles'ı güncelle
create or replace function public.sync_profile_auth_status()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  update public.profiles
  set
    email = new.email,
    email_confirmed_at = new.email_confirmed_at
  where id = new.id;
  return new;
end;
$$;

drop trigger if exists on_auth_user_email_confirmed on auth.users;
create trigger on_auth_user_email_confirmed
  after update of email, email_confirmed_at on auth.users
  for each row execute function public.sync_profile_auth_status();

drop policy if exists "profiles_insert_own" on public.profiles;
create policy "profiles_insert_own" on public.profiles
  for insert with check (auth.uid() = id);
