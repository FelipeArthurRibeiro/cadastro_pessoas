class Pessoa {
  int? id;
  late String nome;
  late String email;
  late String telefone;
  late bool estadoCivil;

  Pessoa({required this.nome, required this.email, required this.telefone, required this.estadoCivil});

  Pessoa.fromMap(Map<String, dynamic> map){
    id = map['id'];
    nome = map['nome'];
    telefone = map['telefone'];
    email = map['email'];
    estadoCivil = map['estado_civil'] == 0 ? false : true;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'estado_civil': estadoCivil,
    };
  }

  @override
  String toString() {
    return 'Pessoa{nome: $nome, telefone: $telefone, email: $email, estadoCivil: $estadoCivil}';
  }
}