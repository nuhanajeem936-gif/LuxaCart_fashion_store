import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/product_image.dart';

class ReceiptScreen extends StatelessWidget {
  final double total;
  final List<ProductModel> orderedItems;
  final Map<String, dynamic> deliveryDetails;

  const ReceiptScreen({
    super.key,
    required this.total,
    required this.orderedItems,
    required this.deliveryDetails,
  });

  final Color primary = const Color(0xFFF06292);

  @override
  Widget build(BuildContext context) {
    double shipping = 10.0;
    double subtotal = total - shipping;
    if (subtotal < 0) subtotal = 0;

    return Scaffold(
      backgroundColor: const Color(0xFFFDEFF4),
      appBar: AppBar(
        title: const Text("Receipt"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// ITEMS LIST
            Expanded(
              child: ListView.builder(
                itemCount: orderedItems.length,
                itemBuilder: (context, index) {
                  final item = orderedItems[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),

                    child: Row(
                      children: [

                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),

                          child: ProductImage(
                            imagePath: item.image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "Qty: ${item.quantity}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Text(
                          "\$${(item.price * item.quantity).toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            /// DELIVERY SUMMARY CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF6F9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_shipping_outlined, color: primary, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        "Shipping Details",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Text(
                    deliveryDetails['fullName'] ?? "Customer",
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Phone: ${deliveryDetails['phone'] ?? 'N/A'}",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${deliveryDetails['address'] ?? 'N/A'}, ${deliveryDetails['city'] ?? ''} - ${deliveryDetails['zipCode'] ?? ''}",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            /// TOTAL SECTION
            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),

              child: Column(
                children: [

                  _buildRow("Subtotal", subtotal),
                  _buildRow("Shipping", shipping),

                  const Divider(),

                  _buildRow("Total", total, isBold: true),

                  const SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },

                      child: const Text(
                        "Continue Shopping",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    String title,
    double value, {
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 15 : 13,
            ),
          ),

          Text(
            "\$${value.toStringAsFixed(2)}",
            style: TextStyle(
              color: isBold ? primary : Colors.black,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 13,
            ),
          ),
        ],
      ),
    );
  }
}