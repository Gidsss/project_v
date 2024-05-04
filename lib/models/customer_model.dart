// import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  String? photoUrl;
  List<String>? roles; // List of roles
  String? password;

  Customer({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
    this.photoUrl,
    this.roles,
    this.password,
  });

  Customer.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id']! as String,
            name: json['name']! as String,
            email: json['email']! as String,
            phoneNumber: json['phoneNumber']! as String,
            address: json['address']! as String,
            photoUrl: json['photoUrl']! as String,
            password: json['password']! as String,
            roles: json['roles'] != null
                ? List<String>.from(json['roles'])
                : null);

  Customer copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
    String? photoUrl,
    List<String>? roles,
    String? password,
  }) {
    return Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        photoUrl: photoUrl ?? this.photoUrl,
        roles: roles ?? this.roles,
        password: password ?? this.password);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'photoUrl': photoUrl,
      'roles': roles,
      'password': password,
    };
  }
}
