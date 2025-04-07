import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class User {

  const User({
    this.id,
    this.email,
  });

  final int? id;
  final String? email;

  factory User.fromJson(Map<String,dynamic> json) => User(
    id: json['id'] != null ? json['id'] as int : null,
    email: json['email']?.toString()
  );

  factory User.fromSnapshot(Map<Object?,Object?> json) => User(
    id: json['id'] != null ? json['id'] as int : null,
    email: json['email']?.toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email
  };

  

  User clone() => User(
    id: id,
    email: email
  );


  User copyWith({
    Optional<int?>? id,
    Optional<String?>? email
  }) => User(
    id: checkOptional(id, () => this.id),
    email: checkOptional(email, () => this.email),
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is User && id == other.id && email == other.email;

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}
