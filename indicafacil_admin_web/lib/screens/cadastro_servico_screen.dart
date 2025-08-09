import 'package:flutter/material.dart';
import '../models/servico.dart';
import '../services/servico_service.dart';
import '../models/user.dart';

class CadastroServicoScreen extends StatefulWidget {
  final User user;
  const CadastroServicoScreen({super.key, required this.user});

  @override
  State<CadastroServicoScreen> createState() => _CadastroServicoScreenState();
}

class _CadastroServicoScreenState extends State<CadastroServicoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _codigo = TextEditingController();
  final TextEditingController _categoria = TextEditingController();
  final TextEditingController _descricaoCurta = TextEditingController();
  final TextEditingController _descricaoCompleta = TextEditingController();
  final TextEditingController _preco = TextEditingController();
  final TextEditingController _cashbackPercentual = TextEditingController();
  final TextEditingController _cashbackFixo = TextEditingController();
  final TextEditingController _localExecucao = TextEditingController();
  final TextEditingController _ordemExibicao = TextEditingController();
  final TextEditingController _tags = TextEditingController();

  DateTimeRange? _duracaoRange;
  bool _duracaoIndet = false;
  final Set<int> _diasSelecionados = {};
  bool _todosOsDias = false;
  bool _ativo = true;

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final initial = _duracaoRange ?? DateTimeRange(start: now, end: now.add(const Duration(days: 7)));
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: initial,
    );
    if (picked != null) setState(() => _duracaoRange = picked);
  }

  void _toggleTodosOsDias(bool value) {
    setState(() {
      _todosOsDias = value;
      if (value) {
        _diasSelecionados
          ..clear()
          ..addAll(List<int>.generate(7, (i) => i + 1));
      }
    });
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final preco = double.tryParse(_preco.text.replaceAll(',', '.')) ?? 0.0;
    final cashbackPerc = _cashbackPercentual.text.trim().isEmpty
        ? null
        : double.tryParse(_cashbackPercentual.text.replaceAll(',', '.'));
    final cashbackFix = _cashbackFixo.text.trim().isEmpty
        ? null
        : double.tryParse(_cashbackFixo.text.replaceAll(',', '.'));
    final ordem = int.tryParse(_ordemExibicao.text.trim()) ?? 0;

    final servico = Servico(
      nome: _nome.text.trim(),
      codigo: _codigo.text.trim(),
      categoria: _categoria.text.trim().isEmpty ? null : _categoria.text.trim(),
      descricaoCurta: _descricaoCurta.text.trim().isEmpty ? null : _descricaoCurta.text.trim(),
      descricaoCompleta: _descricaoCompleta.text.trim().isEmpty ? null : _descricaoCompleta.text.trim(),
      precoUnitario: preco,
      duracaoInicio: _duracaoIndet ? null : _duracaoRange?.start,
      duracaoFim: _duracaoIndet ? null : _duracaoRange?.end,
      duracaoIndeterminada: _duracaoIndet,
      cashbackPercentual: cashbackPerc,
      cashbackFixo: cashbackFix,
      diasSemana: _todosOsDias ? List<int>.generate(7, (i) => i + 1) : _diasSelecionados.toList()..sort(),
      todosOsDias: _todosOsDias,
      localExecucao: _localExecucao.text.trim(),
      ativo: _ativo,
      ordemExibicao: ordem,
      tags: _tags.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
    );

    ServicoService.instance.add(servico);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Serviço cadastrado')),
    );

    setState(() {
      _formKey.currentState!.reset();
      for (final c in [
        _nome,
        _codigo,
        _categoria,
        _descricaoCurta,
        _descricaoCompleta,
        _preco,
        _cashbackPercentual,
        _cashbackFixo,
        _localExecucao,
        _ordemExibicao,
        _tags,
      ]) {
        c.clear();
      }
      _duracaoRange = null;
      _duracaoIndet = false;
      _diasSelecionados.clear();
      _todosOsDias = false;
      _ativo = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle hint = Theme.of(context).textTheme.bodySmall!;

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Serviços')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: _nome,
                  decoration: const InputDecoration(labelText: 'Nome*', border: OutlineInputBorder()),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Obrigatório';
                    if (!RegExp(r'^[A-Za-zÀ-ÿ\s]+\$?').hasMatch(v.trim())) return 'Apenas letras';
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 180,
                child: TextFormField(
                  controller: _codigo,
                  decoration: const InputDecoration(labelText: 'Código*', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Obrigatório';
                    if (!RegExp(r'^\d+$').hasMatch(v.trim())) return 'Apenas números';
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 220,
                child: TextFormField(
                  controller: _preco,
                  decoration: const InputDecoration(labelText: 'Preço Unitário*', border: OutlineInputBorder()),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Obrigatório';
                    if (double.tryParse(v.replaceAll(',', '.')) == null) return 'Número inválido';
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 220,
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Duração', border: OutlineInputBorder()),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _duracaoIndet
                              ? 'Indeterminado'
                              : (_duracaoRange == null
                                  ? '—'
                                  : '${_duracaoRange!.start.day.toString().padLeft(2, '0')}/${_duracaoRange!.start.month.toString().padLeft(2, '0')}/${_duracaoRange!.start.year} a ${_duracaoRange!.end.day.toString().padLeft(2, '0')}/${_duracaoRange!.end.month.toString().padLeft(2, '0')}/${_duracaoRange!.end.year}'),
                        ),
                      ),
                      IconButton(
                        onPressed: _duracaoIndet ? null : _pickDateRange,
                        icon: const Icon(Icons.date_range),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(value: _duracaoIndet, onChanged: (v) => setState(() => _duracaoIndet = v ?? false)),
                  const Text('Indeterminado')
                ],
              ),
              SizedBox(
                width: 220,
                child: TextFormField(
                  controller: _cashbackPercentual,
                  decoration: const InputDecoration(labelText: 'Cashback (%)', border: OutlineInputBorder()),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) {
                    if (v == null || v.isEmpty) return null;
                    return double.tryParse(v.replaceAll(',', '.')) == null ? 'Número inválido' : null;
                  },
                ),
              ),
              SizedBox(
                width: 220,
                child: TextFormField(
                  controller: _cashbackFixo,
                  decoration: const InputDecoration(labelText: 'Cashback Fixo', border: OutlineInputBorder()),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) {
                    if (v == null || v.isEmpty) return null;
                    return double.tryParse(v.replaceAll(',', '.')) == null ? 'Número inválido' : null;
                  },
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Horários/Dias', border: OutlineInputBorder()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        children: [
                          for (int d = 1; d <= 7; d++)
                            FilterChip(
                              label: Text(_labelDia(d)),
                              selected: _diasSelecionados.contains(d),
                              onSelected: (sel) => setState(() {
                                if (sel) {
                                  _diasSelecionados.add(d);
                                } else {
                                  _diasSelecionados.remove(d);
                                }
                                if (_diasSelecionados.length == 7) {
                                  _todosOsDias = true;
                                } else {
                                  _todosOsDias = false;
                                }
                              }),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Switch(value: _todosOsDias, onChanged: _toggleTodosOsDias),
                          Text('Todos os dias', style: hint),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 280,
                child: TextFormField(
                  controller: _localExecucao,
                  decoration: const InputDecoration(labelText: 'Local de Execução*', border: OutlineInputBorder()),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Obrigatório';
                    if (!RegExp(r'^[A-Za-zÀ-ÿ\s]+\$?').hasMatch(v.trim())) return 'Apenas letras';
                    return null;
                  },
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(value: _ativo, onChanged: (v) => setState(() => _ativo = v)),
                  const Text('Ativo'),
                ],
              ),
              SizedBox(
                width: 160,
                child: TextFormField(
                  controller: _ordemExibicao,
                  decoration: const InputDecoration(labelText: 'Ordem de Exibição', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.isEmpty) return null;
                    if (int.tryParse(v) == null) return 'Número inválido';
                    return null;
                  },
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: TextFormField(
                  controller: _tags,
                  decoration: const InputDecoration(
                    labelText: 'Tags (separadas por vírgula)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: TextFormField(
                  controller: _descricaoCurta,
                  decoration: const InputDecoration(labelText: 'Descrição Curta', border: OutlineInputBorder()),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: TextFormField(
                  controller: _descricaoCompleta,
                  maxLines: 4,
                  decoration: const InputDecoration(labelText: 'Descrição Completa', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar Serviço'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _labelDia(int d) {
    switch (d) {
      case 1:
        return 'Seg';
      case 2:
        return 'Ter';
      case 3:
        return 'Qua';
      case 4:
        return 'Qui';
      case 5:
        return 'Sex';
      case 6:
        return 'Sáb';
      case 7:
        return 'Dom';
      default:
        return '$d';
    }
  }
}