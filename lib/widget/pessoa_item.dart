import 'package:exe_4/model/pessoa.dart';
import 'package:flutter/material.dart';

class PessoaItem extends StatelessWidget {

  Pessoa pessoa;

  Function alterar;
  Function onDelete;

  PessoaItem({required this.pessoa, required this.onDelete, required this.alterar});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(10),
        height: 125,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${pessoa.nome}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 35),
                  ),
                ),
                IconButton(
                  onPressed: (){
                    onDelete();
                  },
                  icon: Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: (){
                    alterar();
                  },
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${pessoa.telefone}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '${pessoa.email}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Row(
              children: [
                Text('${estadoCivilValidator(pessoa)}', style: TextStyle(fontWeight: FontWeight.w700),)
              ],
            ),
          ],
        ),
      ),
    );
  }

  estadoCivilValidator(Pessoa pessoa){
    if(pessoa.estadoCivil == true){
      return 'Casado(a)';
    } else{
      return 'Solteiro(a)';
    }
  }
}
