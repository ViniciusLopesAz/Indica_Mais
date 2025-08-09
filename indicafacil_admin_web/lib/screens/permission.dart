import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class PermissionScreen extends StatelessWidget {
  final User user;
  const PermissionScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    if (!user.isAdmin) {
      return Scaffold(
        appBar: AppBar(title: const Text('Permissões')),
        body: const Center(child: Text('Você não tem permissão para acessar esta página.')),
      );
    }

    final users = UserService.instance.users;

    return Scaffold(
      appBar: AppBar(title: const Text('Permissões')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final u = users[index];
          return ListTile(
            leading: Icon(u.isAdmin ? Icons.verified_user : Icons.person),
            title: Text(u.username),
            subtitle: Text(u.isAdmin ? 'Administrador' : 'Usuário'),
          );
        },
        separatorBuilder: (_, __) => const Divider(),
        itemCount: users.length,
      ),
    );
  }
}