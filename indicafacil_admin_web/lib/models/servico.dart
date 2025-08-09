class Servico {
  String nome; // only letters
  String codigo; // only numbers
  String? categoria;
  String? descricaoCurta;
  String? descricaoCompleta;
  double precoUnitario;
  DateTime? duracaoInicio;
  DateTime? duracaoFim;
  bool duracaoIndeterminada;
  double? cashbackPercentual;
  double? cashbackFixo;
  List<int> diasSemana; // 1=Mon..7=Sun or 0..6? We'll use 1..7
  bool todosOsDias;
  String localExecucao; // letters only
  bool ativo;
  int ordemExibicao;
  List<String> tags;

  Servico({
    required this.nome,
    required this.codigo,
    this.categoria,
    this.descricaoCurta,
    this.descricaoCompleta,
    required this.precoUnitario,
    this.duracaoInicio,
    this.duracaoFim,
    this.duracaoIndeterminada = false,
    this.cashbackPercentual,
    this.cashbackFixo,
    List<int>? diasSemana,
    this.todosOsDias = false,
    required this.localExecucao,
    required this.ativo,
    required this.ordemExibicao,
    List<String>? tags,
  })  : diasSemana = diasSemana ?? <int>[],
        tags = tags ?? <String>[];
}