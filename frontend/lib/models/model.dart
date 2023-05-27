enum Fakultas {
  ftib,
  fteic,
}

Map<String, List<String>> prodi = {
  Fakultas.ftib.name: [
    'Bisnis Digital',
    'Informatika',
    'Rekayasa Perangkat Lunak',
    'Sains Data',
    'Sistem Informasi',
    'Teknologi Informasi',
  ],
  Fakultas.fteic.name: [
    'Teknik Elektro',
    'Teknik Industri',
    'Teknik Komputer',
    'Teknik Logistik',
    'Teknik Telekomunikasi',
  ]
};