-- TickTock PostgreSQL schema (Supabase-compatible)
-- Run in Supabase SQL Editor or via TablePlus (PostgreSQL connection)

-- ─── Profiles (extends Supabase auth.users) ───
create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  email text,
  first_name text not null default '',
  last_name text not null default '',
  profile_image_url text,
  email_confirmed_at timestamptz,
  theme_mode text not null default 'system' check (theme_mode in ('light', 'dark', 'system')),
  locale text not null default 'en',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ─── Todo lists ───
create table if not exists public.todo_lists (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  name text not null,
  color_hex integer,
  created_at timestamptz not null default now()
);

-- ─── Todo items ───
create table if not exists public.todo_items (
  id uuid primary key default gen_random_uuid(),
  list_id uuid not null references public.todo_lists (id) on delete cascade,
  user_id uuid not null references public.profiles (id) on delete cascade,
  title text not null,
  note text,
  completed boolean not null default false,
  due_date timestamptz,
  created_at timestamptz not null default now(),
  completed_at timestamptz
);

-- ─── Calendar events ───
create table if not exists public.calendar_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  title text not null,
  start_at timestamptz not null,
  end_at timestamptz not null,
  all_day boolean not null default false,
  note text,
  color_hex integer,
  todo_item_id uuid references public.todo_items (id) on delete set null,
  created_at timestamptz not null default now()
);

-- ─── Indexes ───
create index if not exists idx_todo_lists_user_id on public.todo_lists (user_id);
create index if not exists idx_todo_items_list_id on public.todo_items (list_id);
create index if not exists idx_todo_items_user_id on public.todo_items (user_id);
create index if not exists idx_todo_items_due_date on public.todo_items (due_date);
create index if not exists idx_calendar_events_user_id on public.calendar_events (user_id);
create index if not exists idx_calendar_events_start_at on public.calendar_events (start_at);

-- ─── Auto-create profile on signup ───
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

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- auth.users onay durumu değişince profiles tablosunu güncelle (Table Editor'da takip için)
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

-- ─── updated_at trigger ───
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists profiles_updated_at on public.profiles;
create trigger profiles_updated_at
  before update on public.profiles
  for each row execute function public.set_updated_at();

-- ─── Row Level Security ───
alter table public.profiles enable row level security;
alter table public.todo_lists enable row level security;
alter table public.todo_items enable row level security;
alter table public.calendar_events enable row level security;

create policy "profiles_select_own" on public.profiles
  for select using (auth.uid() = id);

create policy "profiles_update_own" on public.profiles
  for update using (auth.uid() = id);

create policy "profiles_insert_own" on public.profiles
  for insert with check (auth.uid() = id);

create policy "todo_lists_all_own" on public.todo_lists
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "todo_items_all_own" on public.todo_items
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "calendar_events_all_own" on public.calendar_events
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
