-- Hesap silme (Apple Guideline 5.1.1(v))
-- Supabase SQL Editor'da çalıştır.
-- Oturum açmış kullanıcı kendi auth.users kaydını siler; profiles ve bağlı veriler CASCADE ile gider.

create or replace function public.delete_own_account()
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is null then
    raise exception 'Not authenticated';
  end if;

  delete from auth.users where id = auth.uid();
end;
$$;

revoke all on function public.delete_own_account() from public;
grant execute on function public.delete_own_account() to authenticated;
