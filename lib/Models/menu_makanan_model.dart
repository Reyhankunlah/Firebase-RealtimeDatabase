import 'dart:convert';

// MODEL DIGANTI

class ItemMakanan {
  int hargaMakanan;
  String namaMakanan;

  ItemMakanan({
    required this.hargaMakanan,
    required this.namaMakanan,
  });

  factory ItemMakanan.fromJson(Map<String, dynamic> json) => ItemMakanan(
    hargaMakanan: json["harga_makanan"],
    namaMakanan: json["nama_makanan"],
  );

  Map<String, dynamic> toJson() => {
    "harga_makanan": hargaMakanan,
    "nama_makanan": namaMakanan,
  };

  String get formattedPrice {
    return 'Rp ${hargaMakanan.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
  }
}

class MakananResponse {
  Map<String, ItemMakanan> makanan;

  MakananResponse({
    required this.makanan,
  });

  factory MakananResponse.fromJson(Map<String, dynamic> json) {
    Map<String, ItemMakanan> makananMap = {};
    
    if (json.containsKey("makanan")) {
      final makananData = json["makanan"] as Map<String, dynamic>;
      makananData.forEach((key, value) {
        makananMap[key] = ItemMakanan.fromJson(value);
      });
    }
    
    return MakananResponse(makanan: makananMap);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> makananJson = {};
    makanan.forEach((key, value) {
      makananJson[key] = value.toJson();
    });
    
    return {
      "makanan": makananJson,
    };
  }

  List<MapEntry<String, ItemMakanan>> toList() {
    return makanan.entries.toList();
  }
}