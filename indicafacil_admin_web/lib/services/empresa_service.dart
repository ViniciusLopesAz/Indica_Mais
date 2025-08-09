import '../models/empresa.dart';

class EmpresaService {
  static final EmpresaService instance = EmpresaService._();
  EmpresaService._();

  final List<Empresa> _empresas = [];

  List<Empresa> getAll() => List.unmodifiable(_empresas);

  void add(Empresa empresa) {
    _empresas.add(empresa);
  }

  void removeAt(int index) {
    _empresas.removeAt(index);
  }

  void update(int index, Empresa empresa) {
    _empresas[index] = empresa;
  }
}