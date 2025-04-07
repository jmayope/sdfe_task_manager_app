import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class Task {

  const Task({
    this.userId,
    this.id,
    this.title,
    this.exists,
    this.completed,
  });

  final int? userId;
  final int? id;
  final String? title;
  final bool? exists;
  final bool? completed;

  factory Task.fromJson(Map<String,dynamic> json) => Task(
    userId: json['userId'] != null ? json['userId'] as int : null,
    id: json['id'] != null ? json['id'] as int : null,
    title: json['title']?.toString(),
    exists: json['exists'] != null ? json['exists'] as bool : false,
    completed: json['completed'] != null ? json['completed'] as bool : null
  );

  factory Task.fromSnapshot(Map<Object?,Object?> json) => Task(
    userId: json['userId'] != null ? json['userId'] as int : null,
    id: json['id'] != null ? json['id'] as int : null,
    title: json['title']?.toString(),
    exists: json['exists'] != null ? json['exists'] as bool : false,
    completed: json['completed'] != null ? json['completed'] as bool : null
  );
  
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'id': id,
    'title': title,
    'exists': exists,
    'completed': completed
  };

  Task clone() => Task(
    userId: userId,
    id: id,
    title: title,
    exists: exists,
    completed: completed
  );


  Task copyWith({
    Optional<int?>? userId,
    Optional<int?>? id,
    Optional<String?>? title,
    Optional<bool?>? exists,
    Optional<bool?>? completed
  }) => Task(
    userId: checkOptional(userId, () => this.userId),
    id: checkOptional(id, () => this.id),
    title: checkOptional(title, () => this.title),
    exists: checkOptional(exists, () => this.exists),
    completed: checkOptional(completed, () => this.completed),
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Task && userId == other.userId && id == other.id && title == other.title && exists == other.exists && completed == other.completed;

  @override
  int get hashCode => userId.hashCode ^ id.hashCode ^ title.hashCode ^ exists.hashCode ^ completed.hashCode;
}
