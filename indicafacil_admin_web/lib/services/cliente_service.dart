import '../models/cliente.dart';

class ClienteService {
  static final ClienteService instance = ClienteService._();
  ClienteService._();

  final List<Cliente> _clientes = [];

  List<Cliente> getAll() => List.unmodifiable(_clientes);

  void add(Cliente cliente) {
    _clientes.add(cliente);
  }

  void removeAt(int index) {
    _clientes.removeAt(index);
  }

  void update(int index, Cliente cliente) {
    _clientes[index] = cliente;
  }
}