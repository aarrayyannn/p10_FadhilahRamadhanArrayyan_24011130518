# Aplikasi HR

Aplikasi HR berbasis Flutter untuk mendemonstrasikan pengelolaan pengajuan
cuti, penggajian, dan autentikasi menggunakan beberapa pendekatan state
management.

## Fitur

### Dashboard HRIS

- Ringkasan jumlah karyawan dan pengajuan cuti aktif.
- Navigasi ke modul cuti (Provider), penggajian (Riverpod), dan login (Cubit).
- Tampilan responsif dengan tema abu-abu dan tipografi serif.

### Pengajuan cuti - Provider

- Menampilkan daftar karyawan beserta NIK dan divisinya.
- Mengajukan atau membatalkan cuti per karyawan.
- Badge dan halaman ringkasan menampilkan jumlah serta daftar pengajuan.
- Data pengajuan hanya disimpan selama aplikasi berjalan; belum menggunakan
  penyimpanan permanen.

### Penggajian - Riverpod 3

- Memuat daftar karyawan dan gaji melalui `FutureProvider`.
- Menampilkan detail karyawan, divisi, NIK, dan gaji pokok dalam format Rupiah.
- Memproses penggajian seluruh karyawan dan menampilkan status proses melalui
  `NotifierProvider`.
- Tombol refresh mengatur ulang status penggajian dan memuat ulang daftar.
- Data API saat ini berupa simulasi: daftar memiliki jeda 2 detik dan dapat
  mengalami kegagalan acak; detail memiliki jeda 1 detik. Belum terhubung ke
  server penggajian sungguhan.

### Login dan sesi - Cubit

- Login demo dengan akun yang ditampilkan pada halaman login.
- Memeriksa input dan menampilkan status loading atau pesan kesalahan.
- Menyimpan dan membaca email sesi demo menggunakan `SharedPreferences`.
- Halaman beranda setelah login menyediakan tombol logout.

**Akun demo**

```text
Email: admin@company.com
Password: admin123
```

Login ini hanya untuk demonstrasi. Kredensial masih ditentukan di aplikasi dan
bukan autentikasi produksi.

## Data contoh

Aplikasi menyediakan 10 data karyawan contoh dengan NIK, nama, divisi, dan gaji
pokok. Data tersebut digunakan oleh modul cuti dan penggajian; perubahan tidak
disimpan ke database.

## Teknologi

- Flutter dan Dart
- Provider untuk pengajuan cuti
- Flutter Riverpod 3 untuk daftar, detail, dan status penggajian
- `flutter_bloc` / Cubit dan Equatable untuk autentikasi
- `shared_preferences` untuk menyimpan sesi demo

## Menjalankan aplikasi

Pastikan Flutter SDK sudah terpasang, lalu jalankan dari root proyek:

```bash
flutter pub get
flutter run
```

Untuk menjalankan pengujian:

```bash
flutter test
```

## Struktur modul

```text
lib/
  core/                    Tema dan warna aplikasi
  latihan61_provider/      Pengajuan serta ringkasan cuti
  latihan62_riverpod/      Daftar, detail, dan proses penggajian
  latihan63_bloc/          Login, sesi, dan halaman Cubit
  models/                  Model dan data contoh karyawan
  home_page.dart           Dashboard HRIS
  main.dart                Inisialisasi aplikasi dan state management
```
