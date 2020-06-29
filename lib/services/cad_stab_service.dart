import 'dart:io';

import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CadStabService {
  final db = Firestore.instance.collection('estabelecimentos');
  final storege = FirebaseStorage.instance;
  

  Future<EstabelecimentoModal> cadastrar(EstabelecimentoModal estab,{File image}) async {
    if (image!=null){
      final imagePath = 'imagens/estabelecimentos/${estab.uid}_${DateTime.now()}.jpg';
      final task = storege.ref().child(imagePath).putFile(image);
      final snapshot = await task.onComplete;
      final url = await snapshot.ref.getDownloadURL();

      estab.img = url;
    }
    try {
      await db.document(estab.uid).setData(estab.toJson());
    } catch (e) {
      print("Não foi possível criar o perfil! Erro: $e");
    }
    return estab;
  }

  Future<EstabelecimentoModal> getStab() async {
    EstabelecimentoModal estab;
    final _auth = await FirebaseAuth.instance.currentUser();
    final resp = await db.document(_auth.uid).get();
    print(resp.exists);
    estab = EstabelecimentoModal.fromJson(resp.data);

    return estab;
  }

  Future<List<EstabelecimentoModal>> listarEstabs() async {
    final db = Firestore.instance;
  
    final List<EstabelecimentoModal> lista = [];
    final snapshot = await db.collection("estabelecimentos").getDocuments();
    
    snapshot.documents.forEach((f) => lista.add(EstabelecimentoModal.fromJson(f.data)));
    
    return lista;
  }

}
