import 'package:exe_4/helper/pessoa_helper.dart';
import 'package:exe_4/model/pessoa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Cadastro extends StatefulWidget {
  Cadastro({Key? key, this.pessoa}) : super(key: key);

  Pessoa? pessoa;
  String titulo = 'Cadastro';
  String alteraCadastro = 'cadastrar';

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  bool _valueEstadoCivil = false;

  @override
  void initState() {
    if(widget.pessoa != null){
      widget.titulo = 'Editar';
      widget.alteraCadastro = 'editar';
      _nomeController.text = widget.pessoa!.nome;
      _emailController.text = widget.pessoa!.email;
      _telefoneController.text = widget.pessoa!.telefone;
      _valueEstadoCivil = widget.pessoa!.estadoCivil;
    }
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  var maskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(_nomeController.text.isEmpty && _emailController.text.isEmpty && _telefoneController.text.isEmpty && _valueEstadoCivil == false){
          Navigator.of(context).pop();
        } else {
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text('Deseja descatar?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(primary: Colors.orange),
                        child: Text('Descatar')),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      style: TextButton.styleFrom(primary: Colors.orange),
                      child: Text('Não'),)
                  ],
                ),);
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(widget.titulo),
          backgroundColor: Colors.orange,
        ),
        body: SingleChildScrollView(
          child: Card(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                          controller: _nomeController,
                          validator: (String? value){
                            if(value == null || value.isEmpty){
                              return 'Nome obrigatório';
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Nome',
                            hintText: 'Informe seu nome',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                          ),
                        ),

                      SizedBox(height: 20),

                      TextFormField(
                        controller: _emailController,
                        validator: (String? value){
                          if(value == null || value.isEmpty){
                            return 'E-mail obrigatório';
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          hintText: 'Informe seu e-mail',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                      ),

                      SizedBox(height: 20),

                      TextFormField(
                        controller: _telefoneController,
                        validator:(String? value) {
                          if(value == null || value.isEmpty){
                            return 'Telefone obrigatório';
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Telefone',
                          hintText: 'Informe seu telefone',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskFormatter],
                      ),

                      SizedBox(height: 20),

                      Row(
                        children: [
                          Text('Casado(a)?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),),

                          Switch(
                              value: _valueEstadoCivil,
                              onChanged: (bool newVal) {
                                setState(() {
                                  _valueEstadoCivil = newVal;
                                });
                              }),
                        ],
                      ),

                      ElevatedButton(
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Deseja ${widget.alteraCadastro}?'),
                                  content: Text('Gostaria de ${widget.alteraCadastro}?'),
                                  actions: [
                                    TextButton(
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                        style: TextButton.styleFrom(primary: Colors.orange),
                                        child: Text('Cancelar')),
                                    TextButton(
                                      onPressed: (){
                                        _addLista();
                                        Navigator.of(context).pop();
                                      },
                                      style: TextButton.styleFrom(primary: Colors.orange),
                                      child: Text('OK'),)
                                  ],
                                ),);
                            }
                          },
                          child: Text('Salvar',
                            style: TextStyle(fontSize: 15),))
                    ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addLista(){
    Pessoa pessoa = (Pessoa(
        nome: _nomeController.text,
        email: _emailController.text,
        telefone: _telefoneController.text,
        estadoCivil: _valueEstadoCivil)
    );

    if(widget.pessoa != null) {
      pessoa.id = widget.pessoa!.id;
    }

    PessoaHelper.insert(pessoa).then((pessoaSalva){
      Navigator.of(context).pop();
      Navigator.pop(context, pessoaSalva);
    });

  }

}
