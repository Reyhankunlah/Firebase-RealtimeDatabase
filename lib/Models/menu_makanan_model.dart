import 'dart:convert';

// MODEL DIGANTI

class ItemMakanan {
  final String namaMakanan;
  final int hargaMakanan;
  final int stok;
  final String imageAddress;

  ItemMakanan({
    required this.namaMakanan,
    required this.hargaMakanan,
    required this.stok,
    required this.imageAddress,
  });

  factory ItemMakanan.fromJson(Map<String, dynamic> json) {
    return ItemMakanan(
      namaMakanan: json['nama_makanan'] ?? 'Tanpa Nama',
      hargaMakanan: json['harga_makanan'] ?? 0,
      stok: json['stock_makanan'] ?? 0,
      imageAddress: json['image_address'] ?? 'https://via.placeholder.com/150',
    );
  }

  String get formattedPrice => 'Rp $hargaMakanan';
}

class MakananResponse {
  final Map<String, ItemMakanan> makanan;

  MakananResponse({required this.makanan});

  factory MakananResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, ItemMakanan> temp = {};

    if (json['makanan'] != null) {
      json['makanan'].forEach((key, value) {
        temp[key] = ItemMakanan.fromJson(Map<String, dynamic>.from(value));
      });
    }

    return MakananResponse(makanan: temp);
  }

  List<MapEntry<String, ItemMakanan>> toList() {
    return makanan.entries.toList();
  }
}
