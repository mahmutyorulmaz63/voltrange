# ⚡ VoltRange | Akıllı Batarya & Gerçekçi Menzil Takip Asistanı

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Status](https://img.shields.io/badge/Durum-Mobil_Altyapı_Tamamlandı_|_Donanım_Entegrasyonunda-orange?style=for-the-badge)

Günlük hayatın ve iş temposunun yoğunluğu içinde, mikro mobilite araçlarının (elektrikli bisiklet veya scooter) şarj durumunu sürekli kontrol etmek veya göstergelerin tutarlılığını takip etmek her zaman mümkün olmuyor. Standart göstergeler ise çoğu zaman anlık voltaj dalgalanmalarına (yokuş çıkarken seviyenin aniden düşmesi gibi) bağlı olarak değişkenlik gösterdiği için güvenilir bir menzil bilgisi sunamıyor ve sürücüyü beklenmedik anlarda yarı yolda bırakabiliyor.

Bu projeye tam olarak bu ihtiyaçtan yola çıkarak başladık: Yoğun tempoda batarya takibiyle vakit kaybetmeden, aracın kalan enerjisini doğrudan **gerçekçi bir menzil (KM)** projeksiyonuna dönüştüren ve batarya sağlığını koruyan akıllı bir asistan geliştirmek.

---

## 🎯 Temel Özellikler & Fonksiyonlar

* **Gerçekçi Menzil Projeksiyonu:** Sabit yüzdelik göstergeler yerine, akü paketinin deşarj karakteristiğini baz alarak anlık tahmini menzili (KM) hesaplar.
* **Farklı Akü Konfigürasyonları:** 36V, 48V, 52V ve 60V lityum batarya paketleri için alt ve üst voltaj eşiklerini dinamik olarak tanımlar.
* **Telemetri & Batarya Sağlığı (SOH):** Hücre sıcaklığı (°C), anlık paket voltajı (V) ve şarj döngüsü üzerinden batarya durumunu izler.
* **Çoklu Araç Yönetimi:** Farklı araç modellerini, fabrika menzillerini ve Bluetooth MAC adreslerini tek bir panelden yönetme imkanı sunar.
* **Yerel Veri Saklama:** `shared_preferences` entegrasyonu sayesinde araç profilleri ve kullanıcı ayarları cihaz hafızasında güvenle korunur.

---

## 📐 Hesaplama Mantığı

Lityum bataryaların deşarj eğrisi doğrusal değildir. Uygulama, donanımdan gelen paket voltajını akü tipine göre normalize ederek net şarj yüzdesini ve menzili türetir:

$$\text{Şarj Seviyesi (\%)} = \frac{V_{\text{anlık}} - V_{\text{min}}}{V_{\text{max}} - V_{\text{min}}} \times 100$$

$$\text{Tahmini Menzil (KM)} = \text{Şarj Seviyesi} \times \text{Tam Şarj Fabrika Menzili}$$

### Desteklenen Voltaj Aralıkları
* **36V Akü (10S):** 30.0V (Boş) $\leftrightarrow$ 42.0V (Dolu)
* **48V Akü (13S):** 39.0V (Boş) $\leftrightarrow$ 54.6V (Dolu)
* **52V Akü (14S):** 42.0V (Boş) $\leftrightarrow$ 58.8V (Dolu)
* **60V Akü (16S):** 48.0V (Boş) $\leftrightarrow$ 67.2V (Dolu)

---

## 🗺️ Geliştirme Yol Haritası

- [x] Mobil Arayüz & Slate Dark Tema Tasarımı
- [x] Dinamik Voltaj ve Menzil Hesaplama Algoritması
- [x] Çoklu Araç Tanımlama ve Yerel Hafıza (`shared_preferences`) Entegrasyonu
- [ ] **ESP32 & Gerilim Bölücü Devresi:** Fiziksel voltaj ve sıcaklık sensör devresinin kurulması
- [ ] **Bluetooth (BLE) Bağlantısı:** ESP32 telemetri verilerinin mobil uygulamaya kablosuz aktarılması

---

## 🛠️ Kullanılan Teknolojiler

* **Mobil Framework:** Flutter & Dart
* **Tasarım:** Slate Dark Arayüz Mimarisi & Google Fonts (Poppins)
* **Veri Yönetimi:** `shared_preferences` & JSON Serialization
* **Donanım Hedefi:** ESP32 Mikrodenetleyici (Bluetooth Low Energy / UART)

---

## 💻 Kurulum ve Çalıştırma

```bash
# 1. Projeyi klonlayın
git clone [https://github.com/mahmutyorulmaz63/voltrange.git](https://github.com/mahmutyorulmaz63/voltrange.git)

# 2. Proje dizinine gidin
cd voltrange

# 3. Bağımlılıkları yükleyin
flutter pub get

# 4. Uygulamayı çalıştırın
flutter run
