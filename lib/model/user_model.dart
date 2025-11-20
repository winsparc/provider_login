class UserModel {
  final int id;
  final String name;
  final String email;
  final int age;
  final String image;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      age: json['age'],
      image: json['image'] ?? "",
    );
  }
}
