# TickTock Database

## SQLite vs PostgreSQL?

| | SQLite (sqflite) | PostgreSQL (Supabase) |
|---|---|---|
| Konum | Sadece cihazda | Bulutta, canlı |
| TablePlus | Yerel `.db` dosyası | Uzak PostgreSQL bağlantısı |
| Çok cihaz / kullanıcı | Hayır | Evet |
| TickTock | Eski: Hive (offline) | **Önerilen: canlı DB** |

**Canlı DB** için PostgreSQL (Supabase) kullanıyoruz. `.env` dosyası yoksa uygulama geçici olarak Hive ile çalışmaya devam eder.

---

## 1. Supabase projesi oluştur

1. [supabase.com](https://supabase.com) → New project
2. **SQL Editor** → `database/schema.sql` içeriğini yapıştır → Run
3. **Authentication → Providers → Email** → geliştirme için "Confirm email" kapatabilirsin
4. **Project Settings → API Keys** → `Project URL` ve `anon` key'i kopyala

## 2. Flutter `.env`

```bash
cp .env.example .env
```

`.env` dosyasını doldur:

```
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbG...
```

## 3. TablePlus bağlantısı (PostgreSQL)

Supabase Dashboard → **Project Settings → Database**:

| Alan | Değer |
|------|--------|
| **Type** | PostgreSQL |
| **Host** | `db.YOUR_PROJECT_REF.supabase.co` |
| **Port** | `5432` |
| **User** | `postgres` |
| **Password** | Database password (proje oluştururken verilen) |
| **Database** | `postgres` |
| **SSL** | Required / Enable |

Tablolar: `profiles`, `todo_lists`, `todo_items`, `calendar_events`

> `auth.users` Supabase Auth şemasında; TablePlus'tan görmek için `auth` şemasına erişim gerekir.

---

## Şema özeti

```
auth.users (Supabase Auth)
    └── profiles (1:1)
            ├── todo_lists
            │       └── todo_items
            └── calendar_events
```

### profiles
- `first_name`, `last_name`, `profile_image_url`
- `theme_mode` (`light` | `dark` | `system`)
- `locale` (ör. `tr`, `en`)

### todo_lists
- `user_id`, `name`, `color_hex`

### todo_items
- `list_id`, `user_id`, `title`, `note`, `completed`, `due_date`

### calendar_events
- `user_id`, `title`, `start_at`, `end_at`, `note`, `color_hex`, `todo_item_id`
