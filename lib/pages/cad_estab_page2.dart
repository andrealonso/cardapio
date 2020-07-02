import 'dart:io';

import 'package:cardapio/controllers/estab_controller.dart';
import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/pages/home_page.dart';
import 'package:cardapio/pages/inicial_page.dart';
import 'package:cardapio/services/estab_service.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CadEstabStep2 extends StatefulWidget {
  final EstabelecimentoModal estab;
  final File file;
  final bool editar;

  const CadEstabStep2({Key key, this.estab, this.file, this.editar=false}) : super(key: key);
  @override
  _CadEstabStep2State createState() => _CadEstabStep2State();
}

class _CadEstabStep2State extends State<CadEstabStep2> {
  final formkey = GlobalKey<FormState>();
  final userAtual = GetIt.I<UserController>().usuarioAtual;

  final listaComidas = [
    {'nome': 'Pizza', 'ativo': false},
    {'nome': 'Carne', 'ativo': true},
    {'nome': 'Saladas', 'ativo': true},
    {'nome': 'Buffer', 'ativo': false},
    {'nome': 'Vegana', 'ativo': false},
    {'nome': 'Prato executivo', 'ativo': false},
    {'nome': 'Massas', 'ativo': true},
    {'nome': 'Lanche', 'ativo': true},
    {'nome': 'Frutos do mar', 'ativo': true},
    {'nome': 'Frango', 'ativo': true},
    {'nome': 'Outros', 'ativo': true}
  ];

  List<ItemComidas> lista = [];

  _CadEstabStep2State();

  void addLista() {
    listaComidas.forEach((f) {
      lista.add(ItemComidas(
        nome: f['nome'],
        ativo: f['ativo'],
        clicar: () {
          setState(() {
            f['ativo'] = !f['ativo'];
          });
        },
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    print(userAtual?.nome);
    addLista();
    setState(() {});
  }

  Widget build(BuildContext context) {
    var _estab = widget.estab;
    print(widget.editar);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cadastro de estabelecimento'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Text(
                    'Descreva seu restaurante',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  // minLines: 3,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (value) {},
                  onSaved: (value) {
                    _estab.descricao = value;
                  },
                  initialValue: _estab != null ? _estab.descricao : null,
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Text(
                    'Tipos de comidas',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  // color: Colors.black12,
                  width: double.infinity,
                  child: Wrap(
                    // alignment: WrapAlignment.start,
                    // crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    runSpacing: 4,
                    children: lista,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  // minLines: 3,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (value) {},
                  onSaved: (value) {
                    _estab.outrosTipos = value;
                  },
                  initialValue: _estab != null ? _estab.outrosTipos : null,
                ),
                SizedBox(
                  height: 30,
                ),
                BotaoWidget(
                  nome: widget.editar?'Alterar':'Cadastrar',
                  clicar: () {
                    if (formkey.currentState.validate()) {
                      formkey.currentState.save();
                      _estab.uid = userAtual.uid;
                      if (widget.editar){
                        _atualizar(_estab);
                      }
                      _cadastrar(_estab);
                    }
                  },
                ),
                Container(
                height: 40,
              ),
              Visibility(
                visible: widget.editar,
                child: BotaoWidget(
                  cor: Colors.red[600],
                  nome: 'Excluir',
                  clicar: () {
                    print('Clicou em excluir');
                    _excluir(_estab);
                  },
                ),
              ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _cadastrar(EstabelecimentoModal estab) async {
    try {
      var _estabCadastrado =
          await EstabService().cadastrar(estab, image: widget.file);

      print(_estabCadastrado);
      GetIt.I<EstabController>().setEstab(estab);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print(e);
    }
  }

  _atualizar(EstabelecimentoModal estab) async {
    try {
      var _estabCadastrado =
          await EstabService().atualizar(estab, image: widget.file);

      print(_estabCadastrado);
      GetIt.I<EstabController>().setEstab(estab);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print(e);
    }
  }

  _excluir(EstabelecimentoModal estab) async {
    await EstabService().excluir(estab.uid);
    print('Usuario excluído com sucesso!');
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Inicial()));
  }
}

class ItemComidas extends StatelessWidget {
  final String nome;
  final Function clicar;
  final bool ativo;

  const ItemComidas({this.nome, this.clicar, this.ativo});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
        child: Text(
          nome,
          style: TextStyle(
              fontSize: 18, color: ativo == true ? Colors.white : Colors.black),
        ),
        decoration:
            BoxDecoration(color: ativo == true ? Colors.blue : Colors.black12),
      ),
      onTap: clicar,
    );
  }
}
