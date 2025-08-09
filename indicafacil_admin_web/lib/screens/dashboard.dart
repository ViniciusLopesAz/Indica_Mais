import 'package:flutter/material.dart';
import '../models/user.dart';

class DashboardScreen extends StatelessWidget {
  final User user;

  const DashboardScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<_MenuItem> items = [
      _MenuItem('Cadastro de Clientes', Icons.people, '/clientes'),
      _MenuItem('Cadastro de Empresas', Icons.business, '/empresas'),
      _MenuItem('Cashback', Icons.attach_money, '/cashback'),
      _MenuItem('Cadastrar Cashback', Icons.add_card, '/cadastro_cashback'),
      _MenuItem('Permissões', Icons.lock_person, '/permission'),
      _MenuItem('Cadastrar Serviços', Icons.home_repair_service, '/cadastro_servico'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('IndicaFácil Admin - Dashboard'),
        actions: [
          Center(child: Text(user.isAdmin ? 'Admin' : 'Usuário')),
          const SizedBox(width: 16),
          IconButton(
            tooltip: 'Sair',
            onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final int crossAxisCount = constraints.maxWidth > 900
              ? 3
              : constraints.maxWidth > 600
                  ? 2
                  : 1;
          return GridView.count(
            crossAxisCount: crossAxisCount,
            padding: const EdgeInsets.all(16),
            children: [
              for (final item in items)
                Card(
                  child: InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                      item.route,
                      arguments: user,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(item.icon, size: 40),
                          const SizedBox(height: 8),
                          Text(item.title, textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  final String route;
  const _MenuItem(this.title, this.icon, this.route);
}