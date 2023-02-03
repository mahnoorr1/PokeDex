import 'package:equatable/equatable.dart';
class User extends Equatable{
  final String id;
  final String name;
  final String email;
  const User({required this.id, required this.name, required this.email});

  static const empty = User(id: '', email: '', name: '');
  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, email];

}