import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../viewmodels/product_viewmodel.dart';
import '../widgets/product_image.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatelessWidget {
  final String category;
  final String searchQuery;
  final bool showAppBar;

  const ProductListScreen({
    super.key,
    required this.category,
    this.searchQuery = "",
    this.showAppBar = true,
  });

  final Color primary = const Color(0xFFF06292);
  final Color bgColor = const Color(0xFFFDE4EC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      /// APP BAR
      appBar: showAppBar
          ? AppBar(
              backgroundColor: bgColor,
              elevation: 0,
              centerTitle: true,
              title: Text(
                category,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
            )
          : null,

      body: Column(
        children: [
          /// FILTER TABS
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                buildTab("Popular", true),
                buildTab("New Arrival", false),
                buildTab("Skirts", false),
                buildTab("Dresses", false),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// FIREBASE PRODUCTS
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, snapshot) {
                /// LOADING
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                /// EMPTY CHECK
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No Products Found"));
                }

                final docs = snapshot.data?.docs ?? [];

                /// FILTER PRODUCTS
                final filteredProducts = docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;

                  final matchCategory =
                      category == "All" || data["category"] == category;

                  final matchSearch = searchQuery.isEmpty ||
                      data["name"]
                          .toString()
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase());

                  return matchCategory && matchSearch;
                }).toList();

                if (filteredProducts.isEmpty) {
                  return const Center(child: Text("No Products"));
                }

                final productVM = Provider.of<ProductViewModel>(context);

                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  itemCount: filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final data =
                        filteredProducts[index].data() as Map<String, dynamic>;

                    /// âœ… FIXED: Use fromJson to normalize image paths
                    final productData = Map<String, dynamic>.from(data);
                    productData['id'] = filteredProducts[index].id;
                    // Map 'name' â†’ 'title' and 'description' â†’ 'details' for fromJson
                    productData['title'] = data['name'] ?? data['title'] ?? '';
                    productData['details'] =
                        data['description'] ?? data['details'] ?? '';
                    final product = ProductModel.fromJson(productData);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(
                              product: product,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// IMAGE
                            Expanded(
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ProductImage(
                                      imagePath: product.image,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(25),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: _ProductHeartButton(
                                      isFavorite: productVM.isFavorite(product),
                                      onPressed: () =>
                                          productVM.toggleFavorite(product),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// DETAILS
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        product.rating.toString(),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Rs. ${product.price.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// TAB WIDGET
  Widget buildTab(String text, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: selected ? primary : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ProductHeartButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onPressed;

  const _ProductHeartButton({
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.92),
      shape: const CircleBorder(),
      child: IconButton(
        tooltip: isFavorite ? "Remove from wishlist" : "Add to wishlist",
        constraints: const BoxConstraints.tightFor(width: 36, height: 36),
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(
          isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: isFavorite ? const Color(0xFFF06292) : Colors.black54,
          size: 20,
        ),
      ),
    );
  }
}
