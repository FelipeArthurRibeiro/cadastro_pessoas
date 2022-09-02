import 'package:exe_4/model/pessoa.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

class PessoaHelperApi {

  criarOuConectar() async {}

  static Future<Pessoa> insert(Pessoa pessoa) async{
    await Dio().post(
        'http://192.168.0.57:8080/pessoas',
          data: {
          'nome': pessoa.nome,
          'email': pessoa.email,
          'telefone': pessoa.telefone,
          'estado_civil': !pessoa.estadoCivil ? 0 : 1
        });
    return pessoa;
  }

  Future<List<Pessoa>> selectAll() async{
    List<Pessoa> pessoas = [];
    var response = await Dio().get('http://192.168.0.57:8080/pessoas');
    print(response.data);
    for (final element in response.data){
      pessoas.add(Pessoa(
          id: element['id'],
          nome: element['nome'],
          email: element['email'],
          telefone: element['telefone'],
          estadoCivil: element['estado_civil'] == 0 ? false : true
      ));
    }
    return pessoas;
  }

  static Future<Pessoa> update(Pessoa pessoa) async {
    await Dio().put('http://192.168.0.57:8080/pessoas/${pessoa.id}',
      data: {
        'nome': pessoa.nome,
        'email': pessoa.email,
        'telefone': pessoa.telefone,
        'estado_civil': !pessoa.estadoCivil ? 0 : 1
      }
    );
    return pessoa;
  }

  static Future<void> deleteById(Pessoa pessoa) async {
    await Dio().delete('http://192.168.0.57:8080/pessoas/${pessoa.id}');
  }
}