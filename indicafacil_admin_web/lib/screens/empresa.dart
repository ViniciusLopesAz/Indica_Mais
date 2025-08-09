import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../models/empresa.dart';
import '../services/empresa_service.dart';
import '../models/user.dart';

class EmpresasScreen extends StatefulWidget {
  final User user;
  const EmpresasScreen({super.key, required this.user});

  @override
  State<EmpresasScreen> createState() => _EmpresasScreenState();
}

class _EmpresasScreenState extends State<EmpresasScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _cnpjMask = MaskTextInputFormatter(mask: '##.###.###/####-##');
  final _telMask = MaskTextInputFormatter(mask: '(##) #####-####');
  final _cepMask = MaskTextInputFormatter(mask: '#####-###');

  final TextEditingController _cnpj = TextEditingController();
  final TextEditingController _razao = TextEditingController();
  final TextEditingController _tel = TextEditingController();
  final TextEditingController _nomeFantasia = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _site = TextEditingController();
  final TextEditingController _endereco = TextEditingController();
  final TextEditingController _cep = TextEditingController();
  final TextEditingController _cidade = TextEditingController();
  final TextEditingController _uf = TextEditingController();
  final TextEditingController _segmento = TextEditingController();

  void _addEmpresa() {
    if (!_formKey.currentState!.validate()) return;
    final empresa = Empresa(
      cnpj: _cnpj.text.trim(),
      razaoSocial: _razao.text.trim(),
      telefone: _tel.text.trim(),
      nomeFantasia: _nomeFantasia.text.trim().isEmpty ? null : _nomeFantasia.text.trim(),
      email: _email.text.trim().isEmpty ? null : _email.text.trim(),
      site: _site.text.trim().isEmpty ? null : _site.text.trim(),
      endereco: _endereco.text.trim().isEmpty ? null : _endereco.text.trim(),
      cep: _cep.text.trim().isEmpty ? null : _cep.text.trim(),
      cidade: _cidade.text.trim().isEmpty ? null : _cidade.text.trim(),
      uf: _uf.text.trim().isEmpty ? null : _uf.text.trim(),
      segmento: _segmento.text.trim().isEmpty ? null : _segmento.text.trim(),
    );
    EmpresaService.instance.add(empresa);
    setState(() {
      _formKey.currentState!.reset();
      for (final c in [
        _cnpj,
        _razao,
        _tel,
        _nomeFantasia,
        _email,
        _site,
        _endereco,
        _cep,
        _cidade,
        _uf,
        _segmento,
      ]) {
        c.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final empresas = EmpresaService.instance.getAll();
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Empresas')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                        width: 240,
                        child: TextFormField(
                          controller: _cnpj,
                          inputFormatters: [_cnpjMask],
                          decoration: const InputDecoration(labelText: 'CNPJ*', border: OutlineInputBorder()),
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Obrigatório' : null,
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _razao,
                          decoration: const InputDecoration(labelText: 'Razão Social*', border: OutlineInputBorder()),
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Obrigatório' : null,
                        ),
                      ),
                      SizedBox(
                        width: 220,
                        child: TextFormField(
                          controller: _tel,
                          inputFormatters: [_telMask],
                          decoration: const InputDecoration(labelText: 'Telefone*', border: OutlineInputBorder()),
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Obrigatório' : null,
                        ),
                      ),
                      SizedBox(
                        width: 260,
                        child: TextFormField(
                          controller: _nomeFantasia,
                          decoration: const InputDecoration(labelText: 'Nome Fantasia', border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        width: 260,
                        child: TextFormField(
                          controller: _email,
                          decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        width: 260,
                        child: TextFormField(
                          controller: _site,
                          decoration: const InputDecoration(labelText: 'Site', border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: _endereco,
                          decoration: const InputDecoration(labelText: 'Endereço', border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: TextFormField(
                          controller: _cep,
                          inputFormatters: [_cepMask],
                          decoration: const InputDecoration(labelText: 'CEP', border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        width: 220,
                        child: TextFormField(
                          controller: _cidade,
                          decoration: const InputDecoration(labelText: 'Cidade', border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          controller: _uf,
                          maxLength: 2,
                          decoration: const InputDecoration(labelText: 'UF', counterText: '', border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        width: 220,
                        child: TextFormField(
                          controller: _segmento,
                          decoration: const InputDecoration(labelText: 'Segmento', border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton.icon(
                          onPressed: _addEmpresa,
                          icon: const Icon(Icons.save),
                          label: const Text('Salvar Empresa'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Empresas (${empresas.length})', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Razão Social')),
                    DataColumn(label: Text('CNPJ')),
                    DataColumn(label: Text('Telefone')),
                  ],
                  rows: [
                    for (final e in empresas)
                      DataRow(cells: [
                        DataCell(Text(e.razaoSocial)),
                        DataCell(Text(e.cnpj)),
                        DataCell(Text(e.telefone)),
                      ])
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}