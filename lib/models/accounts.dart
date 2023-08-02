// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

class Account {
  final String uuid;
  final String email;
  final String password;
  final String role;
  final String avatar;
  final bool verified;
  final bool verified_phone;
  final String name;
  final String country;
  final String phone;
  final DateTime DOB;
  final String level;
  final List<String> learn;
  final DateTime register_date;
  final DateTime last_login;

  Account ({
    required this.uuid,
    required this.email,
    required this.password,
    required this.role,
    required this.avatar,
    required this.verified,
    required this.verified_phone,
    required this.name,
    required this.country,
    required this.phone,
    required this.DOB,
    required this.level,
    required this.learn,
    required this.register_date,
    required this.last_login
  });

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'email': email,
      'password': password,
      'role': role,
      'avatar': avatar,
      'verified': verified,
      'verified_phone': verified_phone,
      'name': name,
      'country': country,
      'phone': phone,
      'DOB': DOB,
      'level': level,
      'learn': learn,
      'register_date': register_date,
      'last_login': last_login
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      uuid: map['uuid'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      role: map['role'] ?? '',
      avatar: map['avatar'] ?? '',
      verified: map['verified'] ?? false,
      verified_phone: map['verified_phone'] ?? false,
      name: map['name'] ?? '',
      country: map['country'] ?? '',
      phone: map['phone'] ?? '',
      DOB: map['DOB'] ?? DateTime.now(),
      level: map['level'] ?? '',
      learn: map['learn'] ?? [],
      register_date: map['register_date'] ?? DateTime.now(),
      last_login: map['last_login'] ?? DateTime.now()
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) => Account.fromMap(json.decode(source));
  
}