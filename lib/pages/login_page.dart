import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/pages/home_page.dart';
import 'package:cardapio/services/perfil_usuario_service.dart';
import 'package:cardapio/widgets/botao_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _service = PerfilUsuarioService();

  var form_user = '';
  var form_pass = '';
  var user_saved = '';
  var pass_saved = '';
  var logado = false;

  _login() async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      try {
        await _auth.signInWithEmailAndPassword(
            email: form_user.trim(), password: form_pass.trim());
        final perfilAtual = await _service.getPerfil();
        print('perfil capturado');

        GetIt.I<UserController>().setUsuario(perfilAtual);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        formkey.currentState.reset();
        print(e);
      }
    }
  }

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
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  labelText: 'Usuário (seu email)',
                ),
                onSaved: (value) {
                  form_user = value;
                },
                validator: (value) {
                  bool emailValid =
                      RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                          .hasMatch(value);
                  if (value.isEmpty) {
                    return 'Preencha o email!';
                  } else {
                    // if (!emailValid){
                    //   return 'O endereço do email não é válido';
                    // }
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
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  labelText: 'Senha',
                ),
                onSaved: (value) {
                  form_pass = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Preench a senha!';
                  } else {
                    if (value.length < 6) {
                      return 'A senha precisa ter no mínimo 6 dígitos';
                    }
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
                    _login();
                    // if (formkey.currentState.validate()) {
                    //   formkey.currentState.save();
                    //   formkey.currentState.reset();
                    //   if (user_saved.isNotEmpty) {
                    //     if (user_saved != form_user ||
                    //         pass_saved != form_pass) {
                    //       print('Usuário ou senha inválida');
                    //     } else {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => HomePage()));
                    //     }
                    //   }

                    // }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
