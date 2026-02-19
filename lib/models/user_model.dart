class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String profilePic;
  final Map<String, dynamic>? location; // 👈 هذا حقل location

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profilePic,
    this.location,
  });

  // ==== From JSON ====
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      profilePic: json['profilePic'] ?? '',
      location: json['location'] != null
          ? Map<String, dynamic>.from(json['location'])
          : null,
    );
  }

  // ==== Empty user for delete / logout ====
  factory UserModel.empty() {
    return UserModel(
      id: '',
      name: '',
      email: '',
      phone: '',
      profilePic: '',
      location: null,
    );
  }
}
