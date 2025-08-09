import 'cliente.dart';
import 'empresa.dart';
import 'servico.dart';

enum CashbackStatus { ativo, usado, expirado }

class Cashback {
  final Cliente cliente;
  final Empresa empresa;
  final Servico servico;
  final double valorCashback;
  CashbackStatus status;
  final DateTime dataEmissao;
  DateTime? dataValidade;

  Cashback({
    required this.cliente,
    required this.empresa,
    required this.servico,
    required this.valorCashback,
    required this.status,
    required this.dataEmissao,
    this.dataValidade,
  });
}