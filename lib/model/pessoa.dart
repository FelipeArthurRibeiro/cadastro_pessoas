class Pessoa {
  String nome;
  String email;
  String telefone;
  bool estadoCivil;
  List<Pessoa> listaPessoas = [];

  Pessoa({required this.nome, required this.email, required this.telefone, required this.estadoCivil});
}