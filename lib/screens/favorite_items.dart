import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/product_viewmodel.dart';
import '../widgets/product_image.dart';
import 'product_detail_screen.dart';

class FavoriteItems extends StatefulWidget {
  const FavoriteItems({super.key});

  @override
  State<FavoriteItems> createState() =>
      _FavoriteItemsState();
}

class _FavoriteItemsState
    extends State<FavoriteItems> {

  final Color primaryColor =
      const Color(0xFFF48FB1);

  /// SELECTED CATEGORY
  String selectedCategory = "All";

  /// CATEGORY LIST
  final List<String> categories = [
    "All",
    "Men",
    "Women",
    "Unisex",
    "Kids",
    "Bags",
    "Cosmetics",
    "Accessories",
    "Footwear",
  ];

  @override
  Widget build(BuildContext context) {

    final productVM =
        Provider.of<ProductViewModel>(context);

    final favorites =
        productVM.favoriteProducts;

    /// ================= FILTER FAVORITES =================
    final filteredFavorites =
        selectedCategory == "All"
            ? favorites
            : favorites.where((item) {
                return item.category ==
                    selectedCategory;
              }).toList();

    return Scaffold(
      backgroundColor:
          const Color(0xFFFDEFF4),

      /// ================= APP BAR =================
      appBar: AppBar(
        backgroundColor:
            const Color(0xFFF06292),

        elevation: 0,

        centerTitle: true,

        title: const Text(
          "Wishlist",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),

        iconTheme:
            const IconThemeData(
          color: Colors.white,
        ),
      ),

      /// ================= BODY =================
      body: Column(
        children: [

          /// ================= CATEGORY MENU =================
          SizedBox(
            height: 65,

            child: ListView.builder(
              scrollDirection:
                  Axis.horizontal,

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),

              itemCount:
                  categories.length,

              itemBuilder:
                  (context, index) {

                final category =
                    categories[index];

                final isSelected =
                    selectedCategory ==
                        category;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory =
                          category;
                    });
                  },

                  child: Container(
                    margin:
                        const EdgeInsets.only(
                      right: 10,
                    ),

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),

                    decoration:
                        BoxDecoration(

                      color: isSelected
                          ? primaryColor
                          : Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                              30),

                      border: Border.all(
                        color: primaryColor
                            .withOpacity(0.4),
                      ),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.04),
                          blurRadius: 6,
                        ),
                      ],
                    ),

                    child: Center(
                      child: Text(
                        category,

                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : primaryColor,

                          fontWeight:
                              FontWeight.w600,

                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// ================= EMPTY FAVORITES =================
          if (filteredFavorites.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  "Your wishlist is empty ❤️",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),
              ),
            )

          /// ================= FAVORITE PRODUCTS =================
          else
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.all(16),

                child: GridView.builder(
                  itemCount:
                      filteredFavorites.length,

                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.72,
                  ),

                  itemBuilder:
                      (context, index) {

                    final item =
                        filteredFavorites[index];

                    return GestureDetector(
                      onTap: () {

                        /// OPEN PRODUCT DETAILS
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailScreen(
                              product: item,
                            ),
                          ),
                        );
                      },

                      child: Container(
                        decoration:
                            BoxDecoration(
                          color: Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                                  20),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(
                                      0.05),

                              blurRadius: 8,
                              spreadRadius: 2,
                            )
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            /// ================= PRODUCT IMAGE =================
                            Expanded(
                              child: Stack(
                                children: [

                                  /// IMAGE
                                  ClipRRect(
                                    borderRadius:
                                        const BorderRadius
                                            .vertical(
                                      top:
                                          Radius.circular(
                                              20),
                                    ),

                                    child:
                                        ProductImage(
                                      imagePath:
                                          item.image,

                                      width: double
                                          .infinity,

                                      fit:
                                          BoxFit.cover,
                                    ),
                                  ),

                                  /// REMOVE FAVORITE BUTTON
                                  Positioned(
                                    top: 8,
                                    right: 8,

                                    child:
                                        GestureDetector(
                                      onTap: () {

                                        /// REMOVE FROM FAVORITES
                                        productVM
                                            .toggleFavorite(
                                                item);
                                      },

                                      child:
                                          Container(
                                        padding:
                                            const EdgeInsets
                                                .all(
                                                    6),

                                        decoration:
                                            const BoxDecoration(
                                          color:
                                              Colors.white,

                                          shape:
                                              BoxShape
                                                  .circle,
                                        ),

                                        child:
                                            const Icon(
                                          Icons.favorite,

                                          color:
                                              Colors.red,

                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// ================= PRODUCT DETAILS =================
                            Padding(
                              padding:
                                  const EdgeInsets
                                      .all(10),

                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  /// PRODUCT TITLE
                                  Text(
                                    item.title,

                                    maxLines: 1,

                                    overflow:
                                        TextOverflow
                                            .ellipsis,

                                    style:
                                        const TextStyle(
                                      fontWeight:
                                          FontWeight
                                              .w600,

                                      fontSize: 13,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 5),

                                  /// BRAND
                                  Text(
                                    item.brand,

                                    style:
                                        const TextStyle(
                                      color:
                                          Colors.grey,

                                      fontSize: 12,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 6),

                                  /// PRICE
                                  Text(
                                    "Rs. ${item.price}",

                                    style:
                                        TextStyle(
                                      color:
                                          primaryColor,

                                      fontWeight:
                                          FontWeight
                                              .bold,

                                      fontSize: 15,
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
                ),
              ),
            ),
        ],
      ),
    );
  }
}