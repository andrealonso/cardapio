import 'dart:io';

import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/models/produto_model.dart';
import 'package:cardapio/pages/cardapio_page.dart';
import 'package:cardapio/services/produto_service.dart';
import 'package:cardapio/util/validacoes.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CadProduto extends StatefulWidget {
  final EstabelecimentoModal estab;
  final ProdutoModel produto;
  final bool editar;

  const CadProduto({Key key, this.estab, this.produto, this.editar = false})
      : super(key: key);
  @override
  _CadProdutoFormState createState() => _CadProdutoFormState();
}

class _CadProdutoFormState extends State<CadProduto> {
  final _formkey = GlobalKey<FormState>();
  ProdutoModel _produto = ProdutoModel();
  final _picker = ImagePicker();
  File file;

  @override
  Widget build(BuildContext context) {
    if (widget.editar) {
      _produto = widget.produto;
    }
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
              SizedBox(
                height: 10,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 300,
                            height: 200,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    image: showImage(), fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: chooseImage,
                            child: Icon(
                              Icons.photo_camera,
                              size: 30,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                  validator: (value) {
                    Validacao().vazio(value);
                    Validacao().tamanho(value, 2);
                  },
                  onSaved: (value) {
                    _produto.nome = value;
                  },
                  initialValue: _produto?.nome,
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
                  initialValue:
                      _produto.preco != null ? _produto.preco.toString() : null,
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
                  },
                  initialValue: _produto?.descricao,
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
                  },
                  initialValue: _produto?.composicao,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BotaoWidget(
                  nome: widget.editar ? 'Atualizar' : 'Cadastrar',
                  clicar: () {
                    if (_formkey.currentState.validate()) {
                      _formkey.currentState.save();
                      if (widget.editar) {
                        _atualizar();
                      } else {
                        _cadastrar();
                      }
                    }
                  }),
              SizedBox(
                height: 30,
              ),
              Visibility(
                visible: widget.editar,
                child: BotaoWidget(
                  cor: Colors.red[600],
                  nome: 'Excluir',
                  clicar: () {
                    print('Clicou em excluir');
                    _excluir(_produto.id);
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
    );
  }

  ImageProvider showImage() {
    if (file != null) {
      return FileImage(file);
    } else {
      if (widget.produto != null && widget.produto.img != null) {
        return NetworkImage(widget.produto.img);
      } else {
        return AssetImage("assets/images/img-estab-padrao.png");
      }
    }
  }

  chooseImage() async {
    var image = await _picker.getImage(
        source: ImageSource.gallery, imageQuality: 85, maxHeight: 800);
    setState(() {
      file = File(image.path);
    });
  }

  _cadastrar() {
    _produto.uid = widget.estab.uid;
    ProdutoService().cadastrar(_produto, image: file);
    _voltar(context);
  }

  _atualizar() async {
    ProdutoService().atualizar(_produto, image: file);
    _voltar(context);
  }

  _excluir(String id) async {
    await ProdutoService().excluir(_produto);
    _voltar(context);
  }

  _voltar(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => CardapioPage(
              estab: widget.estab,
            )));
  }
}
