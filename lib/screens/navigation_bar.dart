import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/cart_viewmodel.dart';

import 'home_screen.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';
import 'profile_screen.dart';
import 'favorite_items.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int index = 0;

  final Color primary = const Color(0xFFF06292);
  final Color bgColor = const Color(0xFFF5F5F5);

  final List<Widget> pages = const [
    HomeScreen(),
    FavoriteItems(),
    CartScreen(),
    ProfileScreen(),
  ];

  final List<IconData> icons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.shopping_bag_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final cartVM = Provider.of<CartViewModel>(context);
    final itemsInCart = cartVM.cartItems;
    final total = cartVM.totalPrice;
    final cartItemCount = itemsInCart.fold<int>(0, (sum, item) => sum + item.quantity);

    return Scaffold(
      backgroundColor: bgColor,

      /// APPBAR
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "LuxaCart",
          style: TextStyle(
            color: Color(0xFF2D2D2D),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),

        actions: [
          IconButton(
            icon: Icon(
              Icons.payment_rounded,
              color: primary,
            ),

            onPressed: () {
              /// EMPTY CART CHECK
              if (itemsInCart.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Cart is empty"),
                  ),
                );
                return;
              }

              /// GO TO CHECKOUT
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CheckoutScreen(
                    total: total,
                  ),
                ),
              );
            },
          ),
        ],
      ),

      /// BODY
      body: pages[index],

      /// FLOATING BUTTON
      floatingActionButton: Container(
        height: 65,
        width: 65,

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          gradient: LinearGradient(
            colors: [
              primary,
              primary.withOpacity(0.7),
            ],
          ),

          boxShadow: [
            BoxShadow(
              color: primary.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  index = 2;
                });
              },

              icon: const Icon(
                Icons.shopping_cart_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            if (cartItemCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Center(
                    child: Text(
                      "$cartItemCount",
                      style: TextStyle(
                        color: primary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      /// BOTTOM NAVIGATION BAR
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 20,
        ),

        child: Container(
          height: 70,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,

            children: List.generate(icons.length, (i) {
              /// SPACE FOR FAB
              if (i == 2) {
                return const SizedBox(width: 50);
              }

              bool selected = index == i;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    index = i;
                  });
                },

                child: AnimatedContainer(
                  duration:
                      const Duration(milliseconds: 300),

                  padding: const EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: selected
                        ? primary.withOpacity(0.15)
                        : Colors.transparent,

                    shape: BoxShape.circle,
                  ),

                  child: Icon(
                    icons[i],
                    size: 26,

                    color: selected
                        ? primary
                        : Colors.grey,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}