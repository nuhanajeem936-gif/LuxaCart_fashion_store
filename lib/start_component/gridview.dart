import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CustomCard extends StatelessWidget {
  final ProductModel item;
  final VoidCallback onFavoritePressed;

  const CustomCard({
    super.key,
    required this.item,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFav = item.isFavorite;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F5), // light pink bg
        borderRadius: BorderRadius.circular(25),

        boxShadow: [
          BoxShadow(
            color: Colors.pink.withValues(alpha: 0.15),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🖼 IMAGE + FAVORITE BUTTON
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  item.image,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              /// FAVORITE
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: onFavoritePressed,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.pink,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// DETAILS
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// TITLE
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 5),

                /// PRICE
                Text(
                  "\$${item.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Color(0xFFF06292),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
