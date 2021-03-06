import 'dart:io';

import 'package:cardapio/controllers/user_controller.dart';
import 'package:cardapio/models/curtidasEstab_modal.dart';
import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cardapio/models/usuario_modal.dart';
import 'package:cardapio/services/produto_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

class EstabService {
  final db = Firestore.instance.collection('estabelecimentos');
  final storege = FirebaseStorage.instance;
  final userAtual = GetIt.I<UserController>().usuarioAtual;

  Future<EstabelecimentoModal> cadastrar(EstabelecimentoModal estab,
      {File image}) async {
    if (image != null) {
      final imagePath =
          'imagens/estabelecimentos/${estab.uid}_${DateTime.now()}.jpg';
      final task = storege.ref().child(imagePath).putFile(image);
      final snapshot = await task.onComplete;
      final url = await snapshot.ref.getDownloadURL();

      estab.img = url;
    }
    try {
      await db.document(estab.uid).setData(estab.toJson());
    } catch (e) {
      print(e);
    }
    return estab;
  }

  Future<EstabelecimentoModal> atualizar(EstabelecimentoModal estab,
      {File image}) async {
    if (image != null) {
      if (estab.img != null) {
        final imgStorage =
            await FirebaseStorage.instance.getReferenceFromUrl(estab.img);
        await imgStorage.delete();
        print("Imagem antiga deletada.");
      }
      final imagePath =
          'imagens/estabelecimentos/${estab.uid}_${DateTime.now()}.jpg';
      final task = storege.ref().child(imagePath).putFile(image);
      final snapshot = await task.onComplete;
      final url = await snapshot.ref.getDownloadURL();

      estab.img = url;
    }
    try {
      await db.document(estab.uid).updateData({
        "img": estab.img,
        "nome": estab.nome,
        "endereco": estab.endereco,
        "cep": estab.cep,
        "horaAbre": estab.horaAbre,
        "horaFecha": estab.horaFecha,
        "descricao": estab.descricao,
        "outrosTipos": estab.outrosTipos
      });
    } catch (e) {
      print(e);
    }
    return estab;
  }

  Future<EstabelecimentoModal> getEstab(String uid) async {
    EstabelecimentoModal estab;

    final resp = await db.document(uid).get();
    estab = EstabelecimentoModal.fromJson(resp.data);
    return estab;
  }

  Future<List<EstabelecimentoModal>> listarEstabs() async {
    final db = Firestore.instance;

    final List<EstabelecimentoModal> lista = [];
    final snapshot = await db.collection("estabelecimentos").getDocuments();
    snapshot.documents.forEach((f) async {
      var estab = EstabelecimentoModal.fromJson(f.data);
      lista.add(estab);
    });

    return lista;
  }

  Future<void> excluir(String uid) async {
    final estab = await EstabService().getEstab(uid);
    try {
      if (estab.img != null) {
        final imgStorage =
            await FirebaseStorage.instance.getReferenceFromUrl(estab.img);
        await imgStorage.delete();
      }
      await ProdutoService().excluirTodos(uid);
      await db.document(estab.uid).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<EstabelecimentoModal> addLike(
      EstabelecimentoModal estab, CurtidaModel curtida) async {
    try {
      final curtidas = await db
          .document(estab.uid)
          .collection("curtidas")
          .document(curtida.uid)
          .setData(curtida.toJson());
      print("Curtida adicionado: ${curtida.nome}");
      estab = await getCurtidas(estab);
      return estab;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<EstabelecimentoModal> delLike(
      EstabelecimentoModal estab, CurtidaModel curtida) async {
    try {
      final curtidas = await db
          .document(estab.uid)
          .collection("curtidas")
          .document(curtida.uid)
          .delete();
      print("Curtida adicionado: ${curtida.nome}");
      estab = await getCurtidas(estab);
      return estab;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<EstabelecimentoModal> getCurtidas(EstabelecimentoModal estab) async {
    final curtidas =
        await db.document(estab.uid).collection('curtidas').getDocuments();
    curtidas.documents
        .forEach((f) => estab.curtidas.add(CurtidaModel.fromJson(f.data)));
    print('teste');
    estab.likes = curtidas.documents.length;

    return estab;
  }
}
