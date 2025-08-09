import '../models/user.dart';

class UserService {
  static final UserService instance = UserService._();
  UserService._();

  final List<User> _users = const [
    User(username: 'admin', password: 'admin123', isAdmin: true),
    User(username: 'user', password: 'user123', isAdmin: false),
  ];

  User? authenticate(String usernameOrEmail, String password) {
    for (final user in _users) {
      if (user.username == usernameOrEmail && user.password == password) {
        return user;
      }
    }
    return null;
  }

  List<User> get users => List.unmodifiable(_users);
}