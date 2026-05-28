class UserModel {
  /// ================= BASIC INFO =================
  final String id;
  final String name;
  final String email;

  /// ================= EXTRA DETAILS =================
  final String location;
  final String phone;
  final String image;

  /// ================= OPTIONAL =================
  final String gender;
  final bool isAdmin;

  /// ================= CONSTRUCTOR =================
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.location = "Jakarta, INA",
    this.phone = "+0000000000",
    this.image =
        "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
    this.gender = "Not Specified",
    this.isAdmin = false,
  });

  /// =========================================================
  /// FROM JSON
  /// =========================================================
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      location: json['location'] ?? "Jakarta, INA",
      phone: json['phone'] ?? "+0000000000",
      image: json['image'] ??
          "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      gender: json['gender'] ?? "Not Specified",
      isAdmin: json['isAdmin'] ?? false,
    );
  }

  /// =========================================================
  /// TO JSON
  /// =========================================================
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'location': location,
      'phone': phone,
      'image': image,
      'gender': gender,
      'isAdmin': isAdmin,
    };
  }

  /// =========================================================
  /// COPY WITH
  /// =========================================================
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? location,
    String? phone,
    String? image,
    String? gender,
    bool? isAdmin,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      gender: gender ?? this.gender,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}