import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';
import '../widgets/product_image.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatelessWidget {
  final String category;
  final String searchQuery;

  const ProductListScreen({
    super.key,
    required this.category,
    this.searchQuery = "",
  });

  final Color primary = const Color(0xFFF06292);
  final Color bgColor = const Color(0xFFFDE4EC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      /// APP BAR
      appBar: AppBar(
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
      ),

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
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .snapshots(),

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

                  final matchSearch =
                      searchQuery.isEmpty ||
                      data["name"]
                          .toString()
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase());

                  return matchCategory && matchSearch;
                }).toList();

                if (filteredProducts.isEmpty) {
                  return const Center(child: Text("No Products"));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredProducts.length,

                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.72,
                  ),

                  itemBuilder: (context, index) {
                    final data =
                        filteredProducts[index].data()
                            as Map<String, dynamic>;

                    /// ✅ FIXED: Use fromJson to normalize image paths
                    final productData = Map<String, dynamic>.from(data);
                    productData['id'] = filteredProducts[index].id;
                    // Map 'name' → 'title' and 'description' → 'details' for fromJson
                    productData['title'] = data['name'] ?? data['title'] ?? '';
                    productData['details'] = data['description'] ?? data['details'] ?? '';
                    final product = ProductModel.fromJson(productData);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailScreen(
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
                              color: Colors.black.withOpacity(0.08),
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
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.vertical(
                                  top: Radius.circular(25),
                                ),

                                child: ProductImage(
                                  imagePath: product.image,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(25),
                                  ),
                                ),
                              ),
                            ),

                            /// DETAILS
                            Padding(
                              padding: const EdgeInsets.all(12),

                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,

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
                                    "₹${product.price.toStringAsFixed(2)}",
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