import 'package:exe_4/model/pessoa.dart';
import 'package:exe_4/pages/tela_cadastro.dart';
import 'package:exe_4/widget/pessoa_item.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Pessoa> listaPessoas = [];
  bool ordenar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pessoa = await Navigator.push(context, MaterialPageRoute(builder: (context)=> Cadastro()));
            setState((){
              listaPessoas.add(pessoa);
            });
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Pessoas'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  ordenarLista();
                });
              },
              icon: Icon(Icons.sort_by_alpha))
        ],
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: listaPessoas.length,
          itemBuilder: (context, item){
            return PessoaItem(pessoa: listaPessoas[item],
                onDelete: (){
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Deseja Excluir?'),
                      actions: [
                        TextButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            style: TextButton.styleFrom(primary: Colors.orange),
                            child: Text('Cancelar')),
                        TextButton(
                            onPressed: (){
                              Pessoa retorna = listaPessoas[item];
                              excluirDaLista(item);
                              Navigator.of(context).pop();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Sucesso',),
                                  backgroundColor: Colors.grey,
                                  action: SnackBarAction(
                                    label: 'Desfazer',
                                    textColor: Colors.blue,
                                    onPressed: (){
                                      setState(() {
                                        adicionaNaLista(retorna);
                                      });
                                    },
                                  ),
                                  duration: Duration(seconds: 5),
                                )
                              );
                            },
                            style: TextButton.styleFrom(primary: Colors.orange),
                            child: Text('Sim'))
                      ],
                  ),);
                },
              alterar: (){
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Deseja editar?'),
                    actions: [
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(primary: Colors.orange),
                          child: Text('Cancelar')),
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                            alterar(
                                listaPessoas[item],
                                item);
                          },
                          style: TextButton.styleFrom(primary: Colors.orange),
                          child: Text('Sim'))
                    ],
                  ),);
              }
            );
          }
      ),
    );
  }
  adicionaNaLista(Pessoa retorna){
      listaPessoas.add(retorna);
  }

  excluirDaLista(int item){
    setState((){
      listaPessoas.removeAt(item);
    });
  }

  alterar(Pessoa pessoa, int item) async {
    final pessoa_edit = await Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro(pessoa: pessoa,)));
    setState((){
      listaPessoas[item] = pessoa_edit;
    });
  }

  ordenarLista(){
    if(!ordenar){
      listaPessoas.sort((Pessoa a, Pessoa b) => a.nome.compareTo(b.nome));
      ordenar = !ordenar;
    } else {
      listaPessoas = listaPessoas.reversed.toList();
      ordenar = !ordenar;
    }
  }
}

