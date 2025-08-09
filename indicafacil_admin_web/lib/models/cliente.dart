class Cliente {
  String nome;
  String cpf;
  String telefone;
  String? cidade;
  String? uf; // 2 chars
  String? endereco;
  String? cep;
  DateTime? dataNascimento;

  Cliente({
    required this.nome,
    required this.cpf,
    required this.telefone,
    this.cidade,
    this.uf,
    this.endereco,
    this.cep,
    this.dataNascimento,
  });
}