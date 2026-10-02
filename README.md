# Latihan — Sistem Perpustakaan

## Kelompok

- **Muhammad Raffi Arrosyid** (1124160189)

---

# A. Dokumen Analisis

## 1. Problem Statement

Sistem perpustakaan membutuhkan mekanisme untuk mengelola peminjaman buku dan perhitungan denda keterlambatan. Anggota hanya diperbolehkan meminjam **maksimal 3 buku** dalam satu waktu. Buku yang sedang dipinjam **tidak dapat dipinjam kembali** oleh anggota tersebut. Jika terjadi keterlambatan dalam pengembalian buku, sistem akan mengenakan denda sebesar **Rp1.000 per hari** keterlambatan.

---

## 2. Actor

Actor yang menggunakan sistem adalah **Petugas Perpustakaan**.

Petugas perpustakaan memberikan atau memasukkan:

- Daftar buku yang sedang dipinjam.
- Judul buku baru yang ingin dipinjam.
- Jumlah hari keterlambatan pengembalian buku.

---

## 3. Input & Output

### Input

| Data | Tipe Data | Contoh |
| :--- | :--- | :--- |
| `daftarPinjaman` | `List<String>` | `['Bumi', 'Laskar Pelangi']` |
| `judulBuku` | `String` | `'Filosofi Teras'` |
| `hariTerlambat` | `int` | `3` |

### Output

Program menampilkan:

- Status peminjaman (`Berhasil` / `Gagal` beserta alasannya).
- List daftar buku pinjaman terbaru.
- Total denda keterlambatan (`Rp`).

---

## 4. Functional Requirement

1. Menerima input daftar buku yang sedang dipinjam dan judul buku baru.
2. Memeriksa batas maksimal peminjaman (maksimal 3 buku).
3. Memeriksa apakah buku yang akan dipinjam sudah ada di daftar pinjaman.
4. Menambahkan buku baru ke daftar pinjaman jika validasi berhasil.
5. Menerima input jumlah hari keterlambatan pengembalian.
6. Menghitung denda keterlambatan berdasarkan jumlah hari (Rp1.000 / hari).
7. Menampilkan respon peminjaman dan jumlah denda.

---

## 5. Business Rules

| Kode | Business Rule |
| :--- | :--- |
| **BR-01** | Anggota hanya dapat meminjam **maksimal 3 buku** secara bersamaan. |
| **BR-02** | Buku yang sedang dipinjam **tidak dapat dipinjam kembali**. |
| **BR-03** | Denda keterlambatan dikenakan sebesar **Rp1.000 per hari**. |

---

## 6. Decomposition

```text
Sistem Perpustakaan
│
├── Validasi Peminjaman
│   ├── Cek kapasitas pinjam (panjang list < 3)
│   └── Cek ketersediaan buku (buku belum ada di list)
│
├── Eksekusi Peminjaman
│   ├── Tambah buku ke daftar pinjaman
│   └── Tampilkan pesan status peminjaman
│
└── Perhitungan Denda
    ├── Cek jumlah hari keterlambatan (> 0 hari)
    └── Hitung total denda (hari × Rp1.000)
```

---

## 7. Pattern Recognition

- **Pola Validasi**: Setiap kali transaksi peminjaman dilakukan, sistem selalu menjalankan dua syarat secara berurutan:
  1. Cek jumlah elemen `List` (`length < 3`).
  2. Cek keberadaan elemen di `List` (`!contains(buku)`).
- **Pola Denda**: Perhitungan denda berupa perkalian linear berdasarkan hari keterlambatan: `Denda = Hari × Rp1.000` (jika hari > 0).

---

## 8. Abstraction

### Atribut & Tipe Data

- `daftarPinjaman` (`List<String>`): Menyimpan kumpulan judul buku aktif.
- `judulBuku` (`String`): Menyimpan judul buku yang diproses.
- `hariTerlambat` (`int`): Menyimpan angka keterlambatan hari.

### Pemodelan Konseptual (Class & Enum)

```text
// Enum Pilihan Status (Konseptual)
enum StatusPeminjaman {
  berhasil,
  gagalMaksimal,
  gagalSudahDipinjam
}

// Class Peminjaman (Konseptual)
class PeminjamanBuku {
  - daftarPinjaman: List<String>
  - hariTerlambat: int

  + cekBisaPinjam(judulBuku: String): bool
  + pinjamBuku(judulBuku: String): void
  + hitungDenda(): int
}
```

---

## 9. Algorithm

### Algoritma Peminjaman Buku

1. Menerima `daftarPinjaman` dan `judulBuku`.
2. Periksa jumlah buku di `daftarPinjaman`. Jika sudah mencapai 3 atau lebih, kembalikan respon peminjaman gagal (BR-01).
3. Periksa apakah `judulBuku` sudah ada di `daftarPinjaman`. Jika ada, kembalikan respon peminjaman gagal (BR-02).
4. Jika kedua syarat lolos, tambahkan `judulBuku` ke `daftarPinjaman` dan kembalikan respon peminjaman berhasil.

### Algoritma Perhitungan Denda

1. Menerima input `hariTerlambat`.
2. Jika `hariTerlambat` kurang dari atau sama dengan 0, set `totalDenda = 0`.
3. Jika `hariTerlambat` lebih dari 0, hitung `totalDenda = hariTerlambat * 1000` (BR-03).
4. Kembalikan nilai `totalDenda`.

---

## 10. Flowchart

```text
[ START ]
    │
    ▼
Input: daftarPinjaman, judulBuku
    │
    ▼
Apakah length(daftarPinjaman) >= 3 ? ──(YA)──► [ Print: Gagal Max 3 Buku ] ──┐
    │                                                                        │
   (TIDAK)                                                                   │
    │                                                                        │
    ▼                                                                        │
Apakah judulBuku ada di list? ───────(YA)──► [ Print: Gagal Sudah Dipinjam ] ┤
    │                                                                        │
   (TIDAK)                                                                   │
    │                                                                        │
    ▼                                                                        │
Tambah judulBuku ke daftarPinjaman                                           │
    │                                                                        │
    ▼                                                                        │
[ Print: Berhasil Meminjam ]                                                 │
    │                                                                        │
    ├◄───────────────────────────────────────────────────────────────────────┘
    ▼
Input: hariTerlambat
    │
    ▼
Apakah hariTerlambat > 0 ? ───(TIDAK)───► totalDenda = 0 ──┐
    │                                                      │
   (YA)                                                    │
    ▼                                                      │
totalDenda = hariTerlambat * 1000                          │
    │                                                      │
    ├◄─────────────────────────────────────────────────────┘
    ▼
[ Print: Total Denda ]
    │
    ▼
 [ END ]
```

---

## 11. Pseudocode

```text
START

// Fungsi Cek Kriteria
FUNCTION cekBisaPinjam(daftarPinjaman, judulBuku)
    IF length(daftarPinjaman) >= 3 THEN
        RETURN FALSE
    END IF

    IF judulBuku IN daftarPinjaman THEN
        RETURN FALSE
    END IF

    RETURN TRUE
END FUNCTION

// Fungsi Eksekusi Pinjam
FUNCTION pinjamBuku(daftarPinjaman, judulBuku)
    IF CALL cekBisaPinjam(daftarPinjaman, judulBuku) THEN
        ADD judulBuku TO daftarPinjaman
        PRINT "Berhasil meminjam " + judulBuku
    ELSE
        PRINT "Gagal meminjam " + judulBuku
    END IF
END FUNCTION

// Fungsi Hitung Denda
FUNCTION hitungDenda(hariTerlambat)
    IF hariTerlambat <= 0 THEN
        RETURN 0
    END IF

    RETURN hariTerlambat * 1000
END FUNCTION

// Program Utama
SET pinjaman ← ["Bumi", "Laskar Pelangi"]

CALL pinjamBuku(pinjaman, "Bumi")
CALL pinjamBuku(pinjaman, "Filosofi Teras")

SET totalDenda ← CALL hitungDenda(3)
PRINT "Total Denda: " + totalDenda

END
```

---

# B. Implementasi Dart

```dart
// Fungsi untuk mengecek apakah buku bisa dipinjam
bool cekBisaPinjam(List<String> daftarPinjaman, String judulBuku) {
  if (daftarPinjaman.length >= 3) {
    return false;
  }
  if (daftarPinjaman.contains(judulBuku)) {
    return false;
  }
  return true;
}

// Fungsi untuk proses peminjaman buku
void pinjamBuku(List<String> daftarPinjaman, String judulBuku) {
  if (cekBisaPinjam(daftarPinjaman, judulBuku)) {
    daftarPinjaman.add(judulBuku);
    print('Berhasil meminjam "$judulBuku"');
  } else {
    print('Gagal meminjam "$judulBuku" (Sudah dipinjam atau batas maksimal 3 buku)');
  }
}

// Fungsi untuk menghitung denda keterlambatan (Rp1.000 / hari)
int hitungDenda(int hariTerlambat) {
  if (hariTerlambat <= 0) {
    return 0;
  }
  return hariTerlambat * 1000;
}

void main() {
  List<String> pinjaman = ['Bumi', 'Laskar Pelangi'];

  print('Daftar Awal: $pinjaman');
  print('-----------------------------------');

  // 1. Coba pinjam buku yang sedang dipinjam
  pinjamBuku(pinjaman, 'Bumi');

  // 2. Coba pinjam buku ke-3 (berhasil)
  pinjamBuku(pinjaman, 'Filosofi Teras');

  // 3. Coba pinjam buku ke-4 (gagal karena max 3)
  pinjamBuku(pinjaman, 'Laut Bercerita');

  print('-----------------------------------');
  print('Daftar Akhir: $pinjaman');

  // Hitung denda keterlambatan
  print('-----------------------------------');
  print('Denda 0 hari : Rp ${hitungDenda(0)}');
  print('Denda 3 hari : Rp ${hitungDenda(3)}');
}
```
