import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/cashback.dart';
import '../services/cashback_service.dart';
import '../models/user.dart';

class CashbackScreen extends StatelessWidget {
  final User user;
  const CashbackScreen({super.key, required this.user});

  String _statusLabel(CashbackStatus s) {
    switch (s) {
      case CashbackStatus.ativo:
        return 'Ativo';
      case CashbackStatus.usado:
        return 'Usado';
      case CashbackStatus.expirado:
        return 'Expirado';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cashbacks = CashbackService.instance.getAll();
    final totalAtivos = CashbackService.instance.totalAtivos();
    final currency = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return Scaffold(
      appBar: AppBar(title: const Text('Cashbacks')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Ativos: ${currency.format(totalAtivos)}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: Card(
                child: ListView.separated(
                  itemCount: cashbacks.length,
                  itemBuilder: (context, index) {
                    final c = cashbacks[index];
                    return ListTile(
                      title: Text('${c.cliente.nome} • ${c.empresa.razaoSocial}'),
                      subtitle: Text('${c.servico.nome} • ${_statusLabel(c.status)}'),
                      trailing: Text(currency.format(c.valorCashback)),
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(height: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}