import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  const Authenticated(this.userId);

  final String userId;

  @override
  List<Object> get props => [userId];

  @override
  String toString() => 'Authenticated { user Id $userId}';
}

class Unauthenticated extends AuthenticationState {}
