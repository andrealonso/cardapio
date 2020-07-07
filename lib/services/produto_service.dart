import 'dart:io';

import 'package:cardapio/models/produto_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProdutoService {
  final db = Firestore.instance.collection('produtos');
  final storege = FirebaseStorage.instance;

  Future<ProdutoModel> cadastrar(ProdutoModel produto, {File image}) async {
    if (image != null) {
      final imagePath = 'imagens/produtos/${produto.uid}_${DateTime.now()}.jpg';
      final task = storege.ref().child(imagePath).putFile(image);
      final snapshot = await task.onComplete;
      final url = await snapshot.ref.getDownloadURL();

      produto.img = url;
    }
    try {
      await db.add(produto.toJson());
      print("Produto cadastrado com sucesso");
    } catch (e) {
      print("Não foi possível cadastrar o produto! Erro: $e");
    }

    return produto;
  }

  Future<ProdutoModel> atualizar(ProdutoModel produto, {File image}) async {
    if (image != null) {
      if (produto.img != null) {
        final imgStorage =
            await FirebaseStorage.instance.getReferenceFromUrl(produto.img);
        await imgStorage.delete();
        print("Imagem antiga deletada.");
      }
      final imagePath = 'imagens/produtos/${produto.uid}_${DateTime.now()}.jpg';
      final task = storege.ref().child(imagePath).putFile(image);
      final snapshot = await task.onComplete;
      final url = await snapshot.ref.getDownloadURL();

      produto.img = url;
    }
    try {
      await db.document(produto.id).updateData({
        "img": produto.img,
        "nome": produto?.nome,
        "descricao": produto.descricao,
        "composicao": produto.composicao,
        "preco": produto.preco,
      });
    } catch (e) {
      print(e);
    }

    return produto;
  }

  Future<ProdutoModel> getProduto() async {
    ProdutoModel produto;
    final _auth = await FirebaseAuth.instance.currentUser();
    final resp = await db.document(_auth.uid).get();

    produto = ProdutoModel.fromJson(resp.data, resp.documentID);

    return produto;
  }

  Future<List<ProdutoModel>> listarProdutos(String uid) async {
    final db = Firestore.instance.collection('produtos');
    List<ProdutoModel> lista = [];

    final query = await db
        .where("uid", isEqualTo: uid)
        .orderBy("nome", descending: true)
        .getDocuments();

    await query.documents.forEach((f) {
      lista.add(ProdutoModel.fromJson(f.data, f.documentID));
    });
    print(lista);
    return lista;
  }

  Future<void> excluir(ProdutoModel produto) async {
    final db = Firestore.instance.collection('produtos');
    try {
      await db.document(produto.id).delete();
      print('produto excluido com sucesso!');
    } catch (e) {
      print(e);
    }
  }

  Future<void> excluirTodos(String uid) async {
    final db = Firestore.instance.collection('produtos');

    final query = db.where("uid", isEqualTo: uid).snapshots();
    query.listen((data) {
      data.documents.forEach((f) {
        print(f.data['nome']);
        f.reference.delete();
      });
    });

    return print("Produtos UID: ${uid} excluidos!");
  }
}
