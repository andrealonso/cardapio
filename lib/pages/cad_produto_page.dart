import 'package:cardapio/widgets/botao_widget.dart';
import 'package:flutter/material.dart';

class CadProdutoForm extends StatefulWidget {
  @override
  _CadProdutoFormState createState() => _CadProdutoFormState();
}

class _CadProdutoFormState extends State<CadProdutoForm> {
  final GlobalKey _formkey = GlobalKey<FormState>();
  @override
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
                    // _estabNovo.nome = value;
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
                  onSaved: (value) {
                    // _estabNovo.nome = value;
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
                    labelText: 'Descrição',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  validator: (value) {},
                  onSaved: (value) {
                    // _estabNovo.nome = value;
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
                    // _estabNovo.nome = value;
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
                clicar: () {},
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
