import 'package:cardapio/home_page.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  var form_user = '';
  var form_pass = '';
  var user_saved = '';
  var pass_saved = '';
  var logado = false;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((instance) {
      user_saved = instance.getString('usuario');
      pass_saved = instance.getString('senha');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('Login'),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 80,
          left: 40,
          right: 40,
          bottom: 50,
        ),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.local_dining,
                size: 140,
                color: Colors.blue,
              ),
              Text(
                'Tela de Login',
                style: TextStyle(
                  color: Color(0xff777777),
                  fontSize: 28,
                ),
              ),
              Container(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Usuário',
                ),
                onSaved: (value) {
                  form_user = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Preencha o usuário!';
                  }
                  return null;
                },
              ),
              Container(
                height: 50,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Senha',
                ),
                onSaved: (value) {
                  form_pass = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Preencha a senha!';
                  }
                  return null;
                },
              ),
              Container(
                height: 50,
              ),
              BotaoWidget(
                  nome: 'Acessar',
                  clicar: () {
                    if (formkey.currentState.validate()) {
                      formkey.currentState.save();
                      formkey.currentState.reset();
                      if (user_saved.isNotEmpty) {
                        if (user_saved != form_user ||
                            pass_saved != form_pass) {
                          print('Usuário ou senha inválida');
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }
                      }
                    }
                    print(user_saved);
                    print(pass_saved);
                  }),
                  
            ],
          ),
        ),
      ),
    );
  }
}
