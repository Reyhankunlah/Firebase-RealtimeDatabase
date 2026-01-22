import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String menuTitle;
  final String description;
  final String price;
  final int stock;
  final VoidCallback? onAddPressed;
  final VoidCallback? onDeletePressed;
  final String? imageUrl;

  const MenuCard({
    super.key,
    required this.menuTitle,
    required this.description,
    required this.price,
    required this.stock,
    this.onAddPressed,
    this.onDeletePressed,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 163,
      margin: const EdgeInsets.symmetric(horizontal:2),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 10,
            offset: Offset(2, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 16,
            top: 32,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
                image: imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(imageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: imageUrl == null
                  ? Icon(
                      Icons.restaurant,
                      size: 50,
                      color: Colors.grey[500],
                    )
                  : null,
            ),
          ),

          Positioned(
            left: 130,
            top: 42,
            right: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menuTitle,
                  style: const TextStyle(
                    color: Color(0xFF121212),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Opacity(
                  opacity: 0.70,
                  child: Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF121212),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.30,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    color: Color(0xFF483649),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            right: 16,
            top: 16,
            child: Container(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Text(
                'Stock: $stock',
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          Positioned(
            right: 56,
            bottom: 16,
            child: GestureDetector(
              onTap: onAddPressed,
              child: Container(
                width: 32,
                height: 32,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  size: 22,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          Positioned(
            right: 16,
            bottom: 16,
            child: GestureDetector(
              onTap: onDeletePressed,
              child: Container(
                width: 32,
                height: 32,
                decoration: ShapeDecoration(
                  color: const Color(0xFFC04747),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.delete_outline,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}