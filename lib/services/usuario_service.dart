import 'dart:io';

import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/models/produto_model.dart';
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
      if (usuario.img != null) {
        final imgStorage =
            await FirebaseStorage.instance.getReferenceFromUrl(usuario.img);
        await imgStorage.delete();
        print("Imagem antiga deletada.");
      }
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
    perfil = await getFavoritos(perfil);
    GetIt.I<UserController>().setUsuario(perfil);
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

  Future<bool> addEstabFavorito(String uid, EstabelecimentoModal estab) async {
    try {
      await db
          .document(uid)
          .collection('estabsFavoritos')
          .document(estab.uid)
          .setData({"uid": estab.uid, "nome": estab.nome});
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  Future<bool> delEstabFavorito(String uid, EstabelecimentoModal estab) async {
    try {
      await db
          .document(uid)
          .collection('estabsFavoritos')
          .document(estab.uid)
          .delete();
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<bool> addProdutoFavorito(String uid, ProdutoModel produto) async {
    try {
      await db
          .document(uid)
          .collection('produtosFavoritos')
          .document(produto.id)
          .setData({"id": produto.id, "nome": produto.nome});
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  Future<bool> delProdutoFavorito(String uid, ProdutoModel produto) async {
    try {
      await db
          .document(uid)
          .collection('produtosFavoritos')
          .document(produto.id)
          .delete();
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<PerfilUsuarioModel> getFavoritos(PerfilUsuarioModel usuario) async {
    try {
      final estabs = await db
          .document(usuario.uid)
          .collection('estabsFavoritos')
          .getDocuments();
      final produtos = await db
          .document(usuario.uid)
          .collection('produtosFavoritos')
          .getDocuments();

      estabs.documents.forEach((data) {
        if (data.exists) {
          usuario.estabsFavoritos.add(data.documentID);
        }
      });

      produtos.documents.forEach((data) {
        if (data.exists) {
          usuario.produtosFavoritos.add(data.documentID);
        }
      });
    } catch (e) {
      print(e);
    }
    return usuario;
  }
}
