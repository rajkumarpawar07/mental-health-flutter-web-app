import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String name;
  final String email;
  final int age;
  final String gender;
  final String password;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.password,
    required this.phoneNumber,
    required this.profilePicture,
  });

  /// static function to create a empty user model
  static UserModel empty() => UserModel(
        id: "",
        name: "",
        email: "",
        phoneNumber: "",
        profilePicture: "",
        age: 0,
        gender: '',
        password: '',
      );

  /// Covert model to JSON
  Map<String, dynamic> toJSON() {
    return {
      'Name': name,
      'Email': email,
      'Age': age,
      'Gender': gender,
      'Password': password,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  /// factory method to create a userModel from a
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        name: data['Name'] ?? '',
        email: data['Email'] ?? '',
        age: data['Age'] ?? 0,
        gender: data['Gender'] ?? '',
        password: data['Password'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
