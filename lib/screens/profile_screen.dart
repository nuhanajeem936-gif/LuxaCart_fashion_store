import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth_viewmodel.dart';
import 'favorite_items.dart';
import 'login_screen.dart';
import 'orders.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final Color bgColor = const Color(0xFFF3F3F3);
  final Color primary = const Color(0xFFF06292);

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    final userProfile = authVM.userProfile;

    return Scaffold(
      backgroundColor: bgColor,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [

                /// HEADER
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                    ),

                    const Text(
                      "Profile",

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    IconButton(
                      icon: Icon(Icons.edit_outlined, color: primary),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EditProfile(),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// PROFILE CARD
                Container(
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(25),

                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withOpacity(0.05),

                        blurRadius: 15,

                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [

                      /// PROFILE IMAGE
                      CircleAvatar(
                        radius: 32,

                        backgroundImage:
                            userProfile != null &&
                                    userProfile
                                        .image
                                        .isNotEmpty &&
                                    userProfile.image
                                        .startsWith(
                                            'http')

                                ? NetworkImage(
                                    userProfile.image,
                                  )

                                : const AssetImage(
                                        "assets/images/model.png",
                                      )
                                    as ImageProvider,
                      ),

                      const SizedBox(width: 15),

                      /// USER DETAILS
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Text(
                              userProfile?.name ??
                                  "User Name",

                              style: const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              userProfile?.email ??
                                  "email@example.com",

                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              userProfile?.location ??
                                  "Location",

                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// MENU ITEMS
                buildMenuItem(
                  Icons.person_outline,
                  "Edit Profile Details",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditProfile(),
                      ),
                    );
                  },
                ),

                buildMenuItem(
                  Icons.shopping_bag_outlined,
                  "My Orders",
                  () {

                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) =>
                            const Orders(),
                      ),
                    );
                  },
                ),

                buildMenuItem(
                  Icons.favorite_border,
                  "Favorites",
                  () {

                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) =>
                            const FavoriteItems(),
                      ),
                    );
                  },
                ),

                buildMenuItem(
                  Icons.location_on_outlined,
                  "Delivery Address",
                  () {},
                ),

                buildMenuItem(
                  Icons.credit_card,
                  "Payment Methods",
                  () {},
                ),

                buildMenuItem(
                  Icons.settings_outlined,
                  "Settings",
                  () {},
                ),

                const SizedBox(height: 20),

                /// LOGOUT BUTTON
                Container(
                  width: double.infinity,
                  height: 55,

                  decoration: BoxDecoration(

                    gradient: LinearGradient(
                      colors: [
                        primary.withOpacity(0.9),
                        primary,
                      ],
                    ),

                    borderRadius:
                        BorderRadius.circular(30),

                    boxShadow: [
                      BoxShadow(
                        color:
                            primary.withOpacity(0.3),

                        blurRadius: 10,

                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),

                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.transparent,

                      shadowColor:
                          Colors.transparent,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30),
                      ),
                    ),

                    onPressed: () async {

                      await authVM.signOut();

                      if (context.mounted) {

                        Navigator.pushAndRemoveUntil(
                          context,

                          MaterialPageRoute(
                            builder: (_) =>
                                const LoginScreen(),
                          ),

                          (route) => false,
                        );
                      }
                    },

                    child: const Text(
                      "Log Out",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                /// SOCIAL ICONS
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: const [

                    Icon(
                      Icons.facebook,
                      color: Colors.grey,
                    ),

                    SizedBox(width: 20),

                    Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                    ),

                    SizedBox(width: 20),

                    Icon(
                      Icons.apple,
                      color: Colors.grey,
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// MENU ITEM
  Widget buildMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {

    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.04),

            blurRadius: 10,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: ListTile(

        leading: Icon(
          icon,
          color: Colors.grey,
        ),

        title: Text(
          title,

          style: const TextStyle(
            fontSize: 14,
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Colors.grey,
        ),

        onTap: onTap,
      ),
    );
  }
}