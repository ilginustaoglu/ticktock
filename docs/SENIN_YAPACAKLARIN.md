# Senin elle yapacakların (5 adım)

Kod tarafı hazır. Aşağıdakileri **sen** yap; geri kalanı uygulama otomatik halleder.

---

## 1. Supabase — şema (bir kez)

- [ ] SQL Editor → `database/schema.sql` → **Run** → Success
- [ ] Zaten şema çalıştırdıysan: `database/migrations/001_profiles_email_confirmed.sql` → **Run** (onay takibi kolonları)

## 2. Supabase — e-posta onayı

**Geliştirme (önerilen):** çok kayıt denemesi yapacaksan limit takılmamak için:
- [ ] **Authentication** → **Providers** → **Email** → **Confirm email** → **KAPALI**

**Canlı / gerçek onay istiyorsan:**
- [ ] **Confirm email** → **AÇIK**
- [ ] **Authentication** → **URL Configuration** → Redirect URLs → `ticktock://login-callback` ekle
- [ ] Özel SMTP kur (Resend / SendGrid) — yoksa saatte ~4 mail limiti var

> Limit dolunca kayıt **Supabase'e hiç eklenmez** ve uygulama hata gösterir. ~1 saat bekle veya Confirm email'i geçici kapat.

## 3. `.env` dosyası (bir kez)

Proje klasöründe `ticktock/.env` dosyasını aç.

**URL zaten yazılı.** Sadece şu satırı doldur:

```
SUPABASE_ANON_KEY=sb_publishable_...   ← API Keys → Publishable → Copy
```

- **Publishable key** yapıştır (`sb_publishable_...`)
- **Secret key** (`sb_secret_...`) asla yazma
- Kaydet (Cmd+S)

## 4. Uygulamayı çalıştır

```bash
cd /Users/ilgin/projects/ticktock
flutter run
```

> `.env` değiştirdikten sonra **hot reload yetmez**. Terminalde `q` ile çık, `flutter run` ile yeniden başlat.

Terminalde şunu görmelisin: `TickTock: Supabase bağlandı → ...`

`buraya_yapistir` veya `Offline mod` görürsen anahtar hâlâ placeholder demektir.

## 5. Test

- [ ] Uygulamada **yeni e-posta** ile kayıt ol (aynı maille tekrar kayıt → yeni mail gitmeyebilir; onay ekranından “Tekrar gönder” kullan)
- [ ] Gelen kutusu + **spam** kontrol et (gönderen: `supabase.io`)
- [ ] Bir **liste** ekle
- [ ] Supabase → **Table Editor** → `profiles` ve `todo_lists` → satır var mı?

### Mail gelmiyorsa (geliştirme kısayolu)

Supabase → **Authentication** → **Users** → kullanıcıyı seç → **Confirm user** (elle onayla, sonra uygulamadan giriş yap).

---

## İsteğe bağlı: TablePlus

**Settings** → **Database** → Host, şifre, SSL → PostgreSQL bağlantısı.  
Detay: `docs/SUPABASE_BASLANGIC.md`

---

## Güvenlik hatırlatması

Secret key’i sohbette paylaştıysan: **API Keys** → secret → **Rotate** (yenile).
