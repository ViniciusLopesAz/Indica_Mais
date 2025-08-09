class Empresa {
  String cnpj; // ##.###.###/####-##
  String razaoSocial;
  String? nomeFantasia;
  String telefone;
  String? email;
  String? site;
  String? endereco;
  String? cep;
  String? cidade;
  String? uf; // 2 chars
  String? segmento;

  Empresa({
    required this.cnpj,
    required this.razaoSocial,
    required this.telefone,
    this.nomeFantasia,
    this.email,
    this.site,
    this.endereco,
    this.cep,
    this.cidade,
    this.uf,
    this.segmento,
  });
}