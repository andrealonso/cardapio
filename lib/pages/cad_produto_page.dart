import 'dart:ffi';

import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/usuario_modal.dart';
import 'package:cardapio/models/produto_model.dart';
import 'package:cardapio/services/cad_produto_service.dart';
import 'package:cardapio/services/perfil_usuario_service.dart';
import 'package:cardapio/services/produto_serv.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CadProdutoForm extends StatefulWidget {
  @override
  _CadProdutoFormState createState() => _CadProdutoFormState();
}

class _CadProdutoFormState extends State<CadProdutoForm> {
  final _formkey = GlobalKey<FormState>();
  ProdutoModel _produto = ProdutoModel();
  final _perfilServe = PerfilUsuarioService();
  var usuarioAtual = PerfilUsuarioModel();

  _getUsuarioAtual() {
    usuarioAtual = GetIt.I<UserController>().usuarioAtual;
    }

  @override
  @override
  void initState() { 
    super.initState();
    _getUsuarioAtual();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de produto'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                child: Center(
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        width: 300,
                        height: 187,
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: FittedBox(
                          child: Icon(
                            Icons.photo,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: -30,
                          right: -40,
                          child: GestureDetector(
                            child: Icon(
                              Icons.photo_camera,
                              size: 35,
                              color: Colors.blue,
                            ),
                            onTap: () {},
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nome do produto',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (value) {},
                  onSaved: (value) {
                    _produto.nome = value;
                    // perfilAtual.nome = value;
                  },
                  // initialValue: perfilAtual?.nome,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Valor R\$',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (value) {},
                  onSaved: (value) => _produto.preco = double.tryParse(value),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (value) {},
                  onSaved: (value) {
                    _produto.descricao = value;
                    // perfilAtual.nome = value;
                  },
                  // initialValue: perfilAtual?.nome,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Composição',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (value) {},
                  onSaved: (value) {
                    _produto.composicao = value;
                    // perfilAtual.nome = value;
                  },
                  // initialValue: perfilAtual?.nome,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BotaoWidget(
                nome: 'Cadastrar',
                clicar: () {
                  _getUsuarioAtual();
                  _formkey.currentState.save();
                  _produto.uid = usuarioAtual.uid;
                  print(_produto.nome);
                  CadProdutoService().cadastrar(_produto);
                },
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
