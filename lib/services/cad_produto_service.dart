import 'package:cardapio/models/produto_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CadProdutoService {
  final db = Firestore.instance.collection('produtos');

  Future<ProdutoModel> cadastrar(ProdutoModel produto) async {
    try {
      await db.add(produto.toJson());
      print("Produto cadastrado com sucesso");
    } catch (e) {
      print("Não foi possível cadastrar o produto! Erro: $e");
    }
    
    return produto;
  }

  Future<ProdutoModel> getProduto() async {
    ProdutoModel estab;
    final _auth = await FirebaseAuth.instance.currentUser();
    final resp = await db.document(_auth.uid).get();
    print(resp.exists);
    estab = ProdutoModel.fromJson(resp.data);

    return estab;
  }

  Future<List<ProdutoModel>> listarProdutos(String uid) async {
    final db = Firestore.instance.collection('produtos');

    final List<ProdutoModel> lista = [];
    // final snapshot = await db.collection("produtos").getDocuments();
    final query = db.where("uid", isEqualTo: uid).snapshots();

    // query.documents.forEach((f) {
    //   lista.add(ProdutoModel.fromJson(f.data));
    // });
    query.listen((data){
      data.documents.forEach((f){
        lista.add(ProdutoModel.fromJson(f.data));
      });
      
    });

    return lista;
  }

  printProdutos(String uid) async {
    final db = Firestore.instance.collection('produtos');

    final List<ProdutoModel> lista = [];
    // final snapshot = await db.collection("produtos").getDocuments();
    final query = await db.where("uid", isEqualTo: uid).getDocuments();

   query.documents.forEach((f){print(f.data['nome']);});
    
  }
}
