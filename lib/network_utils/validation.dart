class Validation {
  // FUNGSI validateJudulkegiatan > NAMA FUNGSI BEBAS
  // String validateJudulkegiatan(String value) { //MENERIMA VALUE DENGAN TYPE STRING
  //   if (value.length < 4) { //VALUE TERSEBUT DI CEK APABILA KURANG DARI 6 KARAKTER
  //     return 'Judulkegiatan Minimal 4 Karakter'; //MAKA ERROR AKAN DITAMPILKAN
  //   }
  //   return null; //SELAIN ITU LOLOS VALIDASI
  // }

  String validateIsikegiatan(String value) {
    if (!value.contains('@')) { //JIKA VALUE MENGANDUNG KARAKTER @
      return 'Judulkegiatan tidak valid'; //MAKA PESAN DITAMPILKAN
    }
    return null;
  }

  String validateJudulkegiatan(String value) {
    if (value.isEmpty) { //JIKA VALUE KOSONG
      return 'Nama Lengkap Harus Diisi'; //MAKA PESAN DITAMPILKAN
    }
    return null;
  }
}