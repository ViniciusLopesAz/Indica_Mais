import '../models/servico.dart';

class ServicoService {
  static final ServicoService instance = ServicoService._();
  ServicoService._();

  final List<Servico> _servicos = [];

  List<Servico> getAll() => List.unmodifiable(_servicos);

  void add(Servico servico) {
    _servicos.add(servico);
  }

  void removeAt(int index) {
    _servicos.removeAt(index);
  }

  void update(int index, Servico servico) {
    _servicos[index] = servico;
  }
}