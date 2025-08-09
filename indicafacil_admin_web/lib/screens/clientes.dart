import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../models/cliente.dart';
import '../services/cliente_service.dart';
import '../models/user.dart';

class ClientesScreen extends StatefulWidget {
  final User user;
  const ClientesScreen({super.key, required this.user});

  @override
  State<ClientesScreen> createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  DateTime? _dataNascimento;

  final _cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');
  final _telMask = MaskTextInputFormatter(mask: '(##) #####-####');
  final _cepMask = MaskTextInputFormatter(mask: '#####-###');

  void _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) setState(() => _dataNascimento = picked);
  }

  void _addCliente() {
    if (!_formKey.currentState!.validate()) return;
    final cliente = Cliente(
      nome: _nomeController.text.trim(),
      cpf: _cpfController.text.trim(),
      telefone: _telefoneController.text.trim(),
      cidade: _cidadeController.text.trim().isEmpty ? null : _cidadeController.text.trim(),
      uf: _ufController.text.trim().isEmpty ? null : _ufController.text.trim(),
      endereco: _enderecoController.text.trim().isEmpty ? null : _enderecoController.text.trim(),
      cep: _cepController.text.trim().isEmpty ? null : _cepController.text.trim(),
      dataNascimento: _dataNascimento,
    );
    ClienteService.instance.add(cliente);
    setState(() {
      _formKey.currentState!.reset();
      _nomeController.clear();
      _cpfController.clear();
      _telefoneController.clear();
      _cidadeController.clear();
      _ufController.clear();
      _enderecoController.clear();
      _cepController.clear();
      _dataNascimento = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final clientes = ClienteService.instance.getAll();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Clientes'),
      ),
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
                    runSpacing: 16,
                    spacing: 16,
                    children: [
                      SizedBox(
                        width: 320,
                        child: TextFormField(
                          controller: _nomeController,
                          decoration: const InputDecoration(labelText: 'Nome', border: OutlineInputBorder()),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Obrigatório';
                            if (!RegExp(r'^[A-Za-zÀ-ÿ\s]+$').hasMatch(v.trim())) {
                              return 'Apenas letras';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: _cpfController,
                          inputFormatters: [_cpfMask],
                          decoration: const InputDecoration(labelText: 'CPF', border: OutlineInputBorder()),
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Obrigatório' : null,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: _telefoneController,
                          inputFormatters: [_telMask],
                          decoration: const InputDecoration(labelText: 'Telefone', border: OutlineInputBorder()),
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Obrigatório' : null,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: _cidadeController,
                          decoration: const InputDecoration(labelText: 'Cidade', border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          controller: _ufController,
                          maxLength: 2,
                          decoration: const InputDecoration(labelText: 'UF', counterText: '', border: OutlineInputBorder()),
                          validator: (v) {
                            if (v == null || v.isEmpty) return null; // optional
                            if (!RegExp(r'^[A-Za-z]{2}$').hasMatch(v)) return '2 letras';
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 260,
                        child: TextFormField(
                          controller: _enderecoController,
                          decoration: const InputDecoration(labelText: 'Endereço', border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        width: 140,
                        child: TextFormField(
                          controller: _cepController,
                          inputFormatters: [_cepMask],
                          decoration: const InputDecoration(labelText: 'CEP', border: OutlineInputBorder()),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: InputDecorator(
                          decoration: const InputDecoration(labelText: 'Data de Nascimento', border: OutlineInputBorder()),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _dataNascimento == null
                                      ? '—'
                                      : DateFormat('dd/MM/yyyy').format(_dataNascimento!),
                                ),
                              ),
                              IconButton(
                                onPressed: _pickDate,
                                icon: const Icon(Icons.calendar_today),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: ElevatedButton.icon(
                          onPressed: _addCliente,
                          icon: const Icon(Icons.save),
                          label: const Text('Salvar Cliente'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Clientes (${clientes.length})', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Nome')),
                    DataColumn(label: Text('CPF')),
                    DataColumn(label: Text('Telefone')),
                    DataColumn(label: Text('Cidade/UF')),
                  ],
                  rows: [
                    for (final c in clientes)
                      DataRow(cells: [
                        DataCell(Text(c.nome)),
                        DataCell(Text(c.cpf)),
                        DataCell(Text(c.telefone)),
                        DataCell(Text('${c.cidade ?? ''}${(c.uf ?? '').isNotEmpty ? '/${c.uf}' : ''}')),
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