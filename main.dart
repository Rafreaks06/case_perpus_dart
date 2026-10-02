// Fungsi untuk mengecek apakah buku bisa dipinjam
bool cekBisaPinjam(List<String> daftarPinjaman, String judulBuku) {
  // Kalau sudah pinjam 3 buku, tidak bisa pinjam lagi
  if (daftarPinjaman.length >= 3) {
    return false;
  }
  // Kalau buku sudah ada di daftar pinjaman, tidak bisa dipinjam lagi
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
  print('Denda 0 hari : Rp ${hitungDenda(0)}');
  print('Denda 3 hari : Rp ${hitungDenda(3)}');
}
