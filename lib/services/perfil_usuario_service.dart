import 'package:cardapio/models/perfil_user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilUsuarioService {
  final db = Firestore.instance.collection('perfil_usuario');

  Future<PerfilUsuarioModel> criarPerfil(PerfilUsuarioModel perfil) async {
    try {
      await db.document(perfil.uid).setData(perfil.toJson());
    } catch (e) {
      print("Não foi possível criar o perfil! Erro: $e");
    }
    return perfil;
  }

  Future<PerfilUsuarioModel> getPerfil() async {
    PerfilUsuarioModel perfil;
    final _auth = await FirebaseAuth.instance.currentUser();
    final resp = await db.document(_auth.uid).get();
    print(resp.exists);
    perfil = PerfilUsuarioModel.fromJson(resp.data);

    return perfil;
  }
}
