import '../models/cashback.dart';

class CashbackService {
  static final CashbackService instance = CashbackService._();
  CashbackService._();

  final List<Cashback> _cashbacks = [];

  List<Cashback> getAll() => List.unmodifiable(_cashbacks);

  void add(Cashback cashback) {
    _cashbacks.add(cashback);
  }

  void removeAt(int index) {
    _cashbacks.removeAt(index);
  }

  double totalAtivos() {
    return _cashbacks
        .where((c) => c.status == CashbackStatus.ativo)
        .fold<double>(0.0, (sum, c) => sum + c.valorCashback);
  }
}