import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/cart_viewmodel.dart';

import 'home_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';
import 'product_list_screen.dart';
import 'wishlist_screen.dart';

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
    ProductListScreen(
      category: "All",
      showAppBar: false,
    ),
    CartScreen(showAppBar: false),
    WishlistScreen(showAppBar: false),
    ProfileScreen(),
  ];

  final List<String> titles = const [
    "LuxaCart",
    "Shop",
    "Cart",
    "Wishlist",
    "Account",
  ];

  final List<_NavItem> navItems = const [
    _NavItem(
      pageIndex: 0,
      icon: Icons.home_rounded,
      label: "Home",
    ),
    _NavItem(
      pageIndex: 1,
      icon: Icons.storefront_rounded,
      label: "Shop",
    ),
    _NavItem(
      pageIndex: 3,
      icon: Icons.favorite_rounded,
      label: "Wishlist",
    ),
    _NavItem(
      pageIndex: 4,
      icon: Icons.person_rounded,
      label: "Profile",
    ),
  ];

  Future<void> _onMenuSelected(String value) async {
    switch (value) {
      case 'home':
        setState(() => index = 0);
        break;
      case 'shop':
        setState(() => index = 1);
        break;
      case 'wishlist':
        setState(() => index = 3);
        break;
      case 'profile':
        setState(() => index = 4);
        break;
      case 'logout':
        final authVM = Provider.of<AuthViewModel>(context, listen: false);
        await authVM.signOut();

        if (!mounted) return;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartVM = Provider.of<CartViewModel>(context);
    final cartItemCount =
        cartVM.cartItems.fold<int>(0, (sum, item) => sum + item.quantity);

    return Scaffold(
      backgroundColor: bgColor,
      extendBody: true,

      /// BODY
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: pages[index]),
          ],
        ),
      ),

      /// FLOATING BUTTON
      floatingActionButton: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              primary,
              primary.withValues(alpha: 0.7),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: primary.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
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
                size: 19,
              ),
            ),
            if (cartItemCount > 0)
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Center(
                    child: Text(
                      "$cartItemCount",
                      style: TextStyle(
                        color: primary,
                        fontSize: 7.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      /// BOTTOM NAVIGATION BAR
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 14,
          right: 14,
          bottom: 12,
        ),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(34),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final item in navItems.take(2)) _buildNavButton(item),
              const SizedBox(width: 38),
              for (final item in navItems.skip(2)) _buildNavButton(item),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.045),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 42,
            height: 42,
            child: PopupMenuButton<String>(
              tooltip: "Menu",
              icon: const Icon(Icons.menu_rounded, color: Color(0xFF252525)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              offset: const Offset(0, 48),
              onSelected: _onMenuSelected,
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'home',
                  child: _HeaderMenuItem(
                    icon: Icons.home_rounded,
                    label: "Home",
                  ),
                ),
                PopupMenuItem(
                  value: 'shop',
                  child: _HeaderMenuItem(
                    icon: Icons.storefront_rounded,
                    label: "Shop",
                  ),
                ),
                PopupMenuItem(
                  value: 'wishlist',
                  child: _HeaderMenuItem(
                    icon: Icons.favorite_rounded,
                    label: "Wishlist",
                  ),
                ),
                PopupMenuItem(
                  value: 'profile',
                  child: _HeaderMenuItem(
                    icon: Icons.person_rounded,
                    label: "Profile",
                  ),
                ),
                PopupMenuDivider(),
                PopupMenuItem(
                  value: 'logout',
                  child: _HeaderMenuItem(
                    icon: Icons.logout_rounded,
                    label: "Logout",
                    isDanger: true,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                titles[index],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF252525),
                  fontWeight: FontWeight.w800,
                  fontSize: 21,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 42,
            height: 42,
            child: IconButton(
              tooltip: "Notifications",
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("No new notifications"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Color(0xFF252525),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(_NavItem item) {
    final bool selected = index == item.pageIndex;
    final bool labelOnly = item.icon == null;

    return Expanded(
      child: Tooltip(
        message: item.label,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: () {
            setState(() {
              index = item.pageIndex;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            height: 48,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: selected
                  ? primary.withValues(alpha: 0.14)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!labelOnly) ...[
                  Icon(
                    item.icon!,
                    size: selected ? 24 : 22,
                    color: selected ? primary : Colors.grey.shade500,
                  ),
                  const SizedBox(height: 3),
                ],
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: TextStyle(
                    color: selected ? primary : Colors.grey.shade500,
                    fontSize: labelOnly ? 11 : (selected ? 10 : 9),
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDanger;

  const _HeaderMenuItem({
    required this.icon,
    required this.label,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDanger ? Colors.red : const Color(0xFF252525);

    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _NavItem {
  final int pageIndex;
  final IconData? icon;
  final String label;

  const _NavItem({
    required this.pageIndex,
    required this.icon,
    required this.label,
  });
}
