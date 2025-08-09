import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/cashback.dart';
import '../models/cliente.dart';
import '../models/empresa.dart';
import '../models/servico.dart';
import '../services/cashback_service.dart';
import '../services/cliente_service.dart';
import '../services/empresa_service.dart';
import '../services/servico_service.dart';
import '../models/user.dart';

class CadastroCashbackScreen extends StatefulWidget {
  final User user;
  const CadastroCashbackScreen({super.key, required this.user});

  @override
  State<CadastroCashbackScreen> createState() => _CadastroCashbackScreenState();
}

class _CadastroCashbackScreenState extends State<CadastroCashbackScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Cliente? _cliente;
  Empresa? _empresa;
  Servico? _servico;
  final TextEditingController _valorController = TextEditingController();
  DateTime _dataEmissao = DateTime.now();
  DateTime? _dataValidade;

  void _pickEmissao() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dataEmissao,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _dataEmissao = picked);
  }

  void _pickValidade() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dataValidade ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _dataValidade = picked);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final valor = double.tryParse(_valorController.text.replaceAll(',', '.')) ?? 0.0;
    final cashback = Cashback(
      cliente: _cliente!,
      empresa: _empresa!,
      servico: _servico!,
      valorCashback: valor,
      status: CashbackStatus.ativo,
      dataEmissao: _dataEmissao,
      dataValidade: _dataValidade,
    );
    CashbackService.instance.add(cashback);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cashback cadastrado')),
    );
    setState(() {
      _formKey.currentState!.reset();
      _cliente = null;
      _empresa = null;
      _servico = null;
      _valorController.clear();
      _dataEmissao = DateTime.now();
      _dataValidade = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final clientes = ClienteService.instance.getAll();
    final empresas = EmpresaService.instance.getAll();
    final servicos = ServicoService.instance.getAll();
    final dateFmt = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Cashback')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(
                width: 320,
                child: DropdownButtonFormField<Cliente>(
                  value: _cliente,
                  decoration: const InputDecoration(labelText: 'Cliente', border: OutlineInputBorder()),
                  items: [
                    for (final c in clientes)
                      DropdownMenuItem(value: c, child: Text(c.nome)),
                  ],
                  onChanged: (v) => setState(() => _cliente = v),
                  validator: (v) => v == null ? 'Selecione' : null,
                ),
              ),
              SizedBox(
                width: 320,
                child: DropdownButtonFormField<Empresa>(
                  value: _empresa,
                  decoration: const InputDecoration(labelText: 'Empresa', border: OutlineInputBorder()),
                  items: [
                    for (final e in empresas)
                      DropdownMenuItem(value: e, child: Text(e.razaoSocial)),
                  ],
                  onChanged: (v) => setState(() => _empresa = v),
                  validator: (v) => v == null ? 'Selecione' : null,
                ),
              ),
              SizedBox(
                width: 320,
                child: DropdownButtonFormField<Servico>(
                  value: _servico,
                  decoration: const InputDecoration(labelText: 'Serviço', border: OutlineInputBorder()),
                  items: [
                    for (final s in servicos)
                      DropdownMenuItem(value: s, child: Text(s.nome)),
                  ],
                  onChanged: (v) => setState(() => _servico = v),
                  validator: (v) => v == null ? 'Selecione' : null,
                ),
              ),
              SizedBox(
                width: 180,
                child: TextFormField(
                  controller: _valorController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Valor do cashback', border: OutlineInputBorder()),
                  validator: (v) => (v == null || v.isEmpty) ? 'Obrigatório' : null,
                ),
              ),
              SizedBox(
                width: 220,
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Data de Emissão', border: OutlineInputBorder()),
                  child: Row(
                    children: [
                      Expanded(child: Text(dateFmt.format(_dataEmissao))),
                      IconButton(onPressed: _pickEmissao, icon: const Icon(Icons.calendar_month)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Data de Validade', border: OutlineInputBorder()),
                  child: Row(
                    children: [
                      Expanded(child: Text(_dataValidade == null ? '—' : dateFmt.format(_dataValidade!))),
                      IconButton(onPressed: _pickValidade, icon: const Icon(Icons.event_available)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}