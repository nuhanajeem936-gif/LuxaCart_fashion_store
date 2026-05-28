import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth_viewmodel.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  static const Color primaryColor = Color(0xFFF48FB1);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;
  late TextEditingController _imageController;

  @override
  void initState() {
    super.initState();

    final authVM = Provider.of<AuthViewModel>(
      context,
      listen: false,
    );

    final user = authVM.userProfile;

    _nameController = TextEditingController(text: user?.name ?? "");
    _phoneController = TextEditingController(text: user?.phone ?? "");
    _locationController = TextEditingController(text: user?.location ?? "");
    _imageController = TextEditingController(text: user?.image ?? "");

    _imageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  String? _validateField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  ImageProvider _getImageProvider(String url) {
    if (url.isNotEmpty && url.startsWith("http")) {
      return NetworkImage(url);
    }
    return const AssetImage("assets/images/model.png");
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFDEFF4),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF6F9),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      /// PROFILE IMAGE
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: primaryColor.withOpacity(0.12),
                            backgroundImage: _getImageProvider(
                              _imageController.text.trim(),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        "Profile Picture Preview",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 28),

                      _buildInputField(
                        label: "Full Name",
                        icon: Icons.person_outline,
                        controller: _nameController,
                        errorName: "Name",
                      ),

                      const SizedBox(height: 16),

                      _buildInputField(
                        label: "Phone Number",
                        icon: Icons.phone_outlined,
                        controller: _phoneController,
                        errorName: "Phone Number",
                        keyboardType: TextInputType.phone,
                      ),

                      const SizedBox(height: 16),

                      _buildInputField(
                        label: "Location",
                        icon: Icons.location_on_outlined,
                        controller: _locationController,
                        errorName: "Location",
                      ),

                      const SizedBox(height: 16),

                      _buildInputField(
                        label: "Profile Image URL",
                        icon: Icons.image_outlined,
                        controller: _imageController,
                        errorName: "Image URL",
                        keyboardType: TextInputType.url,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// SAVE BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: authVM.isLoading
                      ? null
                      : () async {
                          if (!_formKey.currentState!.validate()) return;

                          await authVM.updateProfile(
                            name: _nameController.text.trim(),
                            phone: _phoneController.text.trim(),
                            location: _locationController.text.trim(),
                            imageUrl: _imageController.text.trim(),
                          );

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Profile updated successfully"),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                  child: authVM.isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
                          "Save Changes",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// INPUT FIELD WIDGET
  Widget _buildInputField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String errorName,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) => _validateField(value, errorName),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}