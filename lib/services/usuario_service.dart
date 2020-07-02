import 'dart:io';

import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/usuario_modal.dart';
import 'package:cardapio/services/estab_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

class UsuarioService {
  final db = Firestore.instance.collection('usuarios');
  final storage = FirebaseStorage.instance;

  Future<PerfilUsuarioModel> criarPerfil(PerfilUsuarioModel usuario,
      {File image}) async {
    if (image != null) {
      final imagePath = 'imagens/usuarios/${usuario.uid}_${DateTime.now()}';
      final task = storage.ref().child(imagePath).putFile(image);
      final snapshot = await task.onComplete;
      final url = await snapshot.ref.getDownloadURL();

      usuario.img = url;
    }
    try {
      await db.document(usuario.uid).setData(usuario.toJson());
    } catch (e) {
      print("Não foi possível criar o perfil! Erro: $e");
    }
    GetIt.I<UserController>().setUsuario(usuario);
    return usuario;
  }

  Future<PerfilUsuarioModel> atualizarPerfil(PerfilUsuarioModel usuario,
      {File image}) async {
    if (image != null) {
      final imagePath = 'imagens/usuarios/${usuario.uid}_${DateTime.now()}';
      final task = storage.ref().child(imagePath).putFile(image);
      final snapshot = await task.onComplete;
      final url = await snapshot.ref.getDownloadURL();

      usuario.img = url;
    }
    try {
      await db.document(usuario.uid).updateData({
        "img": usuario.img,
        "nome": usuario.nome,
        "sobrenome": usuario.sobrenome,
      });
    } catch (e) {
      print("Não foi possível atualizar o perfil! Erro: $e");
    }
    GetIt.I<UserController>().setUsuario(usuario);
    return usuario;
  }

  Future<PerfilUsuarioModel> getPerfil() async {
    PerfilUsuarioModel perfil;
    final _auth = await FirebaseAuth.instance.currentUser();
    final resp = await db.document(_auth.uid).get();
    print(resp.exists);
    perfil = PerfilUsuarioModel.fromJson(resp.data);

    return perfil;
  }

  Future<void> excluir(PerfilUsuarioModel usuario) async {
    final alth = FirebaseAuth.instance;
    final user = await alth.currentUser();
    try {
      if (usuario.img != null) {
        final img =
            await FirebaseStorage.instance.getReferenceFromUrl(usuario.img);
        await img.delete();
      }
      await db.document(usuario.uid).delete();
      await EstabService().excluir(usuario.uid);
      user.delete().then((_) {
        print('Usuario deletado');
      }).catchError((onError) {
        print(onError);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
