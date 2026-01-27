import 'package:flutter/material.dart';
import 'package:tugas1_11pplg2/Models/menu_makanan_model.dart';

class MenuCard extends StatelessWidget {
  final String menuTitle;
  final String description;
  final String price;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;
  final String? imageUrl;
  final ItemMakanan? makanan;

  const MenuCard({
    super.key,
    required this.menuTitle,
    required this.description,
    required this.price,
    this.onEditPressed,
    this.onDeletePressed,
    this.imageUrl,
    this.makanan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 163,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 10,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          /// IMAGE
          Positioned(
            left: 16,
            top: 32,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: imageUrl != null
                  ? NetworkImage(imageUrl!)
                  : null,
              backgroundColor: Colors.grey[300],
              child: imageUrl == null
                  ? const Icon(Icons.restaurant, size: 40)
                  : null,
            ),
          ),

          /// TEXT
          Positioned(
            left: 130,
            top: 42,
            right: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menuTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF483649),
                  ),
                ),
              ],
            ),
          ),

          /// EDIT (KANAN ATAS)
          Positioned(
            right: 16,
            top: 16,
            child: _icon(Icons.edit, onEditPressed),
          ),

          /// DELETE (KANAN BAWAH)
          Positioned(
            right: 16,
            bottom: 16,
            child: _icon(
              Icons.delete,
              onDeletePressed,
              bg: const Color(0xFFC04747),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _icon(
    IconData icon,
    VoidCallback? onTap, {
    Color bg = Colors.white,
    Color color = Colors.black87,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
