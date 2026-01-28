import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String menuTitle;
  final String description;
  final String price;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;
  final String? imageUrl;

  const MenuCard({
    super.key,
    required this.menuTitle,
    required this.description,
    required this.price,
    this.onEditPressed,
    this.onDeletePressed,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// IMAGE
          CircleAvatar(
            radius: 40,
            backgroundImage:
                imageUrl != null ? NetworkImage(imageUrl!) : null,
            backgroundColor: Colors.grey[300],
            child: imageUrl == null
                ? const Icon(Icons.restaurant, size: 32)
                : null,
          ),

          const SizedBox(width: 16),

          /// TEXT CONTENT
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE
                Text(
                  menuTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                /// DESCRIPTION
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 10),

                /// PRICE
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

          const SizedBox(width: 12),

          /// ACTION BUTTONS
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _icon(Icons.edit, onEditPressed),
                const SizedBox(height: 12),
                _icon(
                  Icons.delete,
                  onDeletePressed,
                  bg: const Color(0xFFC04747),
                  color: Colors.white,
                ),
              ],
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
