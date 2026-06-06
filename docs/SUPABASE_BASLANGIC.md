# TickTock — Supabase & PostgreSQL Başlangıç Rehberi

Bu rehber sıfırdan başlıyor. Hiç veritabanı bilmiyorsan bile adım adım takip edebilirsin.

---

## 1. Kavramlar (önce bunları anla)

### PostgreSQL nedir?

**PostgreSQL**, verilerin saklandığı **canlı bir veritabanı sunucusudur**. Excel gibi düşün ama:
- İnternette bir sunucuda durur
- Uygulama (TickTock) ve sen (TablePlus) aynı veriye bağlanırsın
- Birden fazla kullanıcının verisi güvenli şekilde ayrılır

### Supabase nedir?

**Supabase**, PostgreSQL’i senin için hazır sunan bir platformdur. Yani:
- Kendi sunucunu kurmana gerek yok
- Ücretsiz başlangıç planı var
- Hazır **giriş/kayıt (Auth)** sistemi var
- Web paneli (Dashboard) ile veritabanını yönetirsin

Özet: **Supabase = PostgreSQL + yönetim paneli + kullanıcı girişi**

### TablePlus nedir?

Bilgisayarındaki bir program. Supabase’teki PostgreSQL’e bağlanıp tabloları **Excel gibi** görmeni sağlar. Geliştirici olarak veriyi kontrol etmek için kullanırsın.

### TickTock’ta veri nerede?

```
Kullanıcı (telefon)
    ↓  internet
Supabase (bulut)
    ├── Auth → kim giriş yaptı (e-posta, şifre)
    └── PostgreSQL → listeler, görevler, takvim, profil
```

`.env` dosyasında URL ve anahtar varsa uygulama **Supabase** kullanır. Yoksa geçici olarak telefonda **Hive** (offline) kullanır.

---

## 2. Supabase hesabı ve proje oluşturma

### Adım 2.1 — Kayıt

1. Tarayıcıda aç: https://supabase.com  
2. **Start your project** → GitHub veya e-posta ile kayıt ol  
3. E-postanı doğrula (gerekirse)

### Adım 2.2 — Yeni proje

1. **New project** tıkla  
2. Doldur:
   - **Name:** `ticktock` (istediğin isim)
   - **Database Password:** Güçlü bir şifre **yaz ve bir yere kaydet** (TablePlus için lazım)
   - **Region:** Sana yakın bölge (ör. `Frankfurt` / Avrupa)
3. **Create new project** — 1–2 dakika bekle (yeşil “Active” olana kadar)

---

## 3. Veritabanı tablolarını oluşturma (şema)

TickTock’un tabloları projede hazır: `database/schema.sql`

### Adım 3.1 — SQL Editor

1. Sol menüden **SQL Editor**  
2. **New query**  
3. Bilgisayarında `ticktock/database/schema.sql` dosyasını aç  
4. **Tüm içeriği** kopyala → Supabase editöre yapıştır  
5. Sağ altta **Run** (veya Ctrl+Enter)  
6. Altta **Success** görmelisin

Bu işlem şunları oluşturur:
- `profiles` — ad, soyad, tema, dil
- `todo_lists` — listeler
- `todo_items` — görevler
- `calendar_events` — takvim etkinlikleri
- Güvenlik kuralları (RLS): her kullanıcı sadece kendi verisini görür

### Adım 3.2 — Tabloları kontrol et

Sol menü **Table Editor** → `public` şemasında tabloları görürsün. Henüz satır boş olabilir; uygulamadan kayıt olunca dolacak.

---

## 4. Giriş / kayıt ayarları (önemli)

Geliştirme sırasında e-posta onayı istememek için:

1. Sol menü **Authentication**  
2. **Providers** → **Email**  
3. **Confirm email** → **kapalı** (OFF) yap (test için)  
4. Kaydet

Canlıya çıkarken tekrar açabilirsin.

---

## 5. Flutter uygulamasını Supabase’e bağlama

### Adım 5.1 — API bilgilerini al

1. Sol menü **Project Settings** (dişli ikon) — şu an **General** sayfasındasın, doğru yer  
2. Sol listeden **API Keys** tıkla (Configuration altında)  
3. Kopyala:
   - **Project URL** (sayfanın üstünde veya “Project URL” alanında) → örn. `https://abcdefgh.supabase.co`
   - **anon** / **publishable** key → uzun `eyJ...` ile başlayan metin  

**Data API** menüsü REST ayarları içindir; URL genelde **API Keys** sayfasında da yazar. İkisi de Settings içinde.

> **service_role** / **secret** anahtarını uygulamaya **asla** koyma. Sadece **anon** (public) yeterli.

### Adım 5.2 — `.env` dosyası

Proje klasöründe terminal:

```bash
cd /Users/ilgin/projects/ticktock
cp .env.example .env
```

`.env` dosyasını düzenle:

```
SUPABASE_URL=https://SENIN_PROJECT_REF.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

- `YOUR_PROJECT_REF` yerine kendi URL’ini yaz  
- Anahtarın başında/sonunda boşluk olmasın  
- `.env` dosyası Git’e gitmez (güvenlik için `.gitignore`’da)

### Adım 5.3 — Uygulamayı çalıştır

```bash
flutter pub get
flutter run
```

- Kayıt ol → veriler Supabase’e gider  
- **Table Editor** veya TablePlus’ta satırları görebilirsin  

`.env` yoksa veya yanlışsa uygulama **Hive** (offline) modunda çalışır; TablePlus’ta veri görünmez.

---

## 6. TablePlus ile PostgreSQL bağlantısı

### Adım 6.1 — Bağlantı bilgilerini al

Supabase Dashboard:

1. **Project Settings** → **Database**  
2. **Connection string** bölümüne bak  
3. **Host** genelde: `db.xxxxxxxxxxxx.supabase.co`  
4. **Port:** `5432`  
5. **Database:** `postgres`  
6. **User:** `postgres`  
7. **Password:** Proje oluştururken kaydettiğin **Database Password**

### Adım 6.2 — TablePlus’ta yeni bağlantı

1. TablePlus’ı aç → **Create a new connection**  
2. **PostgreSQL** seç  
3. Alanlar:

| Alan | Değer |
|------|--------|
| Name | TickTock Supabase |
| Host | `db.PROJECT_REF.supabase.co` |
| Port | 5432 |
| User | postgres |
| Password | (kayıtlı DB şifresi) |
| Database | postgres |

4. **SSL** → **Require** veya **Use SSL** açık olsun (Supabase zorunlu kılar)  
5. **Test** → **Connect**

### Adım 6.3 — Tabloları bulma

Bağlandıktan sonra:
- Sol tarafta `postgres` → **Schemas** → **public**  
- `profiles`, `todo_lists`, `todo_items`, `calendar_events`

Kullanıcı hesapları (e-posta) **`auth` şemasında** → `auth.users` tablosu.

---

## 7. Günlük yönetim — neyi nerede yaparsın?

| İş | Nerede |
|----|--------|
| Tablolara bakmak, satır silmek/düzenlemek | Table Editor veya TablePlus |
| SQL sorgusu çalıştırmak | SQL Editor |
| Kayıtlı kullanıcıları görmek | Authentication → Users |
| API anahtarları | Project Settings → API |
| DB şifresi unutuldu | Project Settings → Database → Reset password |
| Yedek / geri yükleme | Database → Backups (plana bağlı) |

### Örnek SQL (SQL Editor)

Tüm listeleri görmek:
```sql
select * from public.todo_lists;
```

Bir kullanıcının görevleri:
```sql
select * from public.todo_items
where user_id = 'KULLANICI-UUID-BURAYA';
```

Kullanıcı UUID’sini: **Authentication → Users** veya `profiles` tablosundan `id` sütunu.

---

## 8. Güvenlik (RLS) — kısaca

Projede **Row Level Security** açık. Anlamı:
- Uygulama, giriş yapmış kullanıcının kimliğiyle istek atar
- PostgreSQL sadece `auth.uid() = user_id` olan satırları döner
- Başka kullanıcının listesini göremezsin

TablePlus’ta `postgres` süper kullanıcı ile bağlandığında **tüm satırları** görürsün (admin gibi). Bu normal.

---

## 9. Sorun giderme

| Sorun | Çözüm |
|-------|--------|
| Kayıt olunca veri yok | `.env` doğru mu? Uygulamayı tam kapatıp `flutter run` |
| “Invalid API key” | `SUPABASE_ANON_KEY` kopyasını yenile, boşluk kalmasın |
| TablePlus bağlanmıyor | SSL açık mı? Şifre proje oluşturma şifresi mi? |
| E-posta onayı istiyor | Authentication → Email → Confirm email kapat |
| Tablolar yok | `schema.sql` tekrar SQL Editor’de Run |

---

## 10. Mimari özeti (TickTock)

```
Kayıt / Giriş
  → Supabase Auth (auth.users)
  → Otomatik profiles satırı (trigger)

Liste ekleme
  → todo_lists (user_id = senin id)

Görev ekleme
  → todo_items (list_id + user_id)

Takvim
  → calendar_events (user_id)

Profil / tema / dil
  → profiles güncellenir
```

Kod tarafı: `lib/core/database/` altındaki repository’ler bu tablolarla konuşur.

---

## 11. Sonraki adımlar (ileride)

- Profil fotoğrafını buluta yüklemek → **Supabase Storage**
- Şifre sıfırlama e-postası → Authentication → Email templates
- Canlı ortam → ayrı Supabase projesi + production `.env`

---

## Hızlı kontrol listesi

- [ ] Supabase hesabı + proje oluşturuldu  
- [ ] Database password kaydedildi  
- [ ] `schema.sql` çalıştırıldı (Success)  
- [ ] Confirm email kapalı (geliştirme)  
- [ ] `.env` → URL + anon key  
- [ ] `flutter run` → kayıt ol → Table Editor’de satır var  
- [ ] TablePlus PostgreSQL bağlantısı + SSL  

Takıldığın adımı yazarsan o adımı birlikte netleştiririz.
