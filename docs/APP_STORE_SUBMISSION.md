# TickTock – App Store’a Gönderme Rehberi

Bu rehber, uygulamayı **ilk kez** App Store’a göndermek için adım adım yapman gerekenleri anlatır.

---

## Ön koşul

- **Apple Developer Program** üyeliği (yıllık ücretli). Daha önce uygulama gönderdiysen zaten vardır.
- Mac’te **Xcode** (güncel sürüm) yüklü olmalı.

---

## Adım 1: Bundle ID’yi değiştir

App Store’da `com.example.*` kullanılamaz. Kendi alan adın veya isminle benzersiz bir Bundle ID seç.

**Seçenek A – Xcode ile (önerilen):**

1. Projeyi Xcode’da aç: `ios/Runner.xcworkspace` (`.xcworkspace`, `.xcodeproj` değil).
2. Sol taraftan **Runner** projesini seç → **TARGETS** → **Runner**.
3. **Signing & Capabilities** sekmesi → **Bundle Identifier** alanı.
4. `com.example.ticktock` yerine örneğin `com.adiniz.ticktock` veya `com.ilgin.ticktock` yaz (dünyada başka kimse kullanmamalı).

**Seçenek B – Dosyadan:**

`ios/Runner.xcodeproj/project.pbxproj` dosyasında tüm `com.example.ticktock` geçen yerleri yeni Bundle ID ile değiştir (ör. `com.adiniz.ticktock`). RunnerTests için `com.adiniz.ticktock.RunnerTests` kalsın.

---

## Adım 2: App Store Connect’te yeni uygulama oluştur

1. [App Store Connect](https://appstoreconnect.apple.com) → giriş yap.
2. **My Apps** → sol üst **+** → **New App**.
3. Doldur:
   - **Platforms:** iOS (işaretli olsun).
   - **Name:** App Store’da görünecek isim (örn. **TickTock**).
   - **Primary Language:** English (veya ana dilin).
   - **Bundle ID:** Açılır listeden **Adım 1**’de Xcode’da yazdığın Bundle ID’yi seç. Listede yoksa önce **Certificates, Identifiers & Profiles**’tan eklemen gerekir (aşağıda).
   - **SKU:** Benzersiz bir kod (örn. `ticktock2025`).
   - **User Access:** Full Access (genelde tek geliştirici).
4. **Create** ile uygulamayı oluştur.

**Bundle ID listede yoksa:**

- [developer.apple.com](https://developer.apple.com) → **Account** → **Certificates, Identifiers & Profiles** → **Identifiers** → **+** → **App IDs** → **App** → Description: TickTock, Bundle ID: **Explicit** → `com.adiniz.ticktock` yaz → kaydet. Sonra App Store Connect’te tekrar **New App** eklerken bu Bundle ID seçilir.

---

## Adım 3: Sürüm bilgisi (version / build)

- **Version (sürüm numarası):** `pubspec.yaml` içinde `version: 1.0.0+1` → kullanıcıya görünen **1.0.0**.
- **Build number:** `+` sonrası **1**. Her App Store’a yüklediğin yeni build’de bu numarayı **artırmalısın** (1.0.0+2, 1.0.0+3 …).

İlk gönderim için `1.0.0+1` yeterli. Sonraki yüklemelerde sadece build numarasını artır (örn. `1.0.0+2`).

---

## Adım 4: Release build al (IPA)

Terminal’de proje klasöründe:

```bash
cd /Users/ilgin/projects/ticktock
flutter clean
flutter pub get
flutter build ipa
```

- İlk seferde **signing** sorulursa: Xcode’da **Runner** target → **Signing & Capabilities** → **Team** kendi Apple Developer hesabını seç, **Automatically manage signing** işaretli olsun.
- Build bitince IPA yolu genelde: `build/ios/ipa/ticktock.ipa`.

---

## Adım 5: IPA’yı App Store Connect’e yükle

**Yöntem A – Transporter (kolay):**

1. Mac App Store’dan **Transporter** uygulamasını indir.
2. Transporter’ı aç → **Deliver** → **+** veya sürükle-bırak ile `build/ios/ipa/ticktock.ipa` dosyasını ekle.
3. **Deliver** ile yükle. Aynı Apple ID ile giriş yapman istenebilir.

**Yöntem B – Xcode:**

1. `open ios/Runner.xcworkspace` ile Xcode’da aç.
2. Üstten cihaz olarak **Any iOS Device (arm64)** seç.
3. Menü: **Product** → **Archive**.
4. Archive tamamlanınca **Organizer** penceresi açılır → en son archive’ı seç → **Distribute App** → **App Store Connect** → **Upload** → gerekli adımları tamamla.

Yükleme bittikten sonra build’in işlenmesi 5–15 dakika sürebilir. **App Store Connect → My Apps → TickTock → TestFlight** veya **iOS App** sekmesinde build görününce devam edersin.

---

## Adım 6: App Store sayfasını doldur

App Store Connect’te **TickTock** uygulamasına gir:

1. **App Information:** Kategori (örn. Productivity), alt kategori, vb.
2. **Pricing and Availability:** Ücretsiz / ücretli, hangi ülkeler.
3. **1.0 Prepare for Submission** bölümüne gir:
   - **Screenshots:** iPhone (ve gerekirse iPad) için gerekli boyutlarda ekran görüntüleri. En az 6.5" ve 5.5" ekran için istenebilir – Xcode Simulator’da ilgili cihazı seçip ekran görüntüsü alabilirsin.
   - **Description:** Uygulama açıklaması (İngilizce veya seçtiğin dil).
   - **Keywords:** Arama anahtar kelimeleri.
   - **Support URL:** Destek sayfası veya e-posta (URL gerekli).
   - **Version:** 1.0.0 (zaten gelir).
   - **Build:** Yüklediğin build’i seç (**+** ile eklenen build çıkana kadar bekleyebilirsin).
   - **App Review Information:** Gerekirse demo hesap, notlar.
   - **Version Release:** Otomatik yayınla veya manuel.

Tüm zorunlu alanlar dolu ve build seçili olmalı.

---

## Adım 7: İncelemeye gönder

- **1.0 Prepare for Submission** sayfasında her şey tamamsa **Add for Review** / **Submit for Review** butonuna tıkla.
- Son birkaç onay ekranını geç (export compliance, reklam, vb. – uygulama içeriğine göre cevapla).
- Gönderim tamamlanınca durum **Waiting for Review** olur. Onay genelde birkaç saat ile birkaç gün sürer.

---

## Özet kontrol listesi

- [ ] Bundle ID `com.example.ticktock` değil, benzersiz (örn. `com.adiniz.ticktock`).
- [ ] App Store Connect’te yeni uygulama oluşturuldu, Bundle ID eşleşiyor.
- [ ] `flutter build ipa` hatasız tamamlandı.
- [ ] IPA Transporter veya Xcode ile yüklendi, build App Store Connect’te görünüyor.
- [ ] Screenshots, açıklama, destek URL’i, build seçimi yapıldı.
- [ ] Submit for Review tıklandı.

---

## Sık karşılaşılan hatalar

- **“No valid signing identity”:** Xcode → Runner → Signing & Capabilities → Team seçili ve sertifika geçerli olmalı.
- **“Bundle ID already in use”:** Başka bir uygulama veya hesap bu ID’yi kullanıyor; farklı Bundle ID seç.
- **Build listede çıkmıyor:** 10–15 dakika bekleyip sayfayı yenile; e-postayı kontrol et.

İlk gönderimde en kritik noktalar: **doğru Bundle ID**, **signing** ve **App Store Connect’te build’i seçip Submit for Review** yapmak.
