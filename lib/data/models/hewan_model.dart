class HewanModel {
  final int id;
  final String nama;
  final String jenis;
  final String tanggalLahir;
  final int harga;
  final String status;

  HewanModel({
    required this.id,
    required this.nama,
    required this.jenis,
    required this.tanggalLahir,
    required this.harga,
    required this.status,
  });

  factory HewanModel.fromJson(Map<String, dynamic> json) {
    return HewanModel(
      id: json['id'] ?? 0,
      nama: json['nama'] ?? '',
      jenis: json['jenis'] ?? '',
      tanggalLahir: json['tanggalLahir'] ?? json['tanggal_lahir'] ?? '',
      harga: json['harga'] ?? 0,
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'jenis': jenis,
      'tanggalLahir': tanggalLahir,
      'harga': harga,
      'status': status,
    };
  }
}
