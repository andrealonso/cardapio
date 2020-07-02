import 'package:cardapio/models/estabelecimento_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EstabServiceFirebase{
  final db = Firestore.instance;
  EstabelecimentoModal estab;  
  
void createRecord() async {
    await db.collection("books")
        .document("1")
        .setData({
          'title': 'Mastering Flutter',
          'description': 'Programming Guide for Dart'
        });

    DocumentReference ref = await db.collection("books")
        .add({
          'title': 'Flutter in Action',
          'description': 'Complete Programming Guide to learn Flutter'
        });
    print(ref.documentID);
  }

  void getData() {
    db
        .collection("books")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  void updateData() {
    try {
      db
          .collection('books')
          .document('1')
          .updateData({'description': 'Head First Flutter'});
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteData() {
    try {
      db
          .collection('books')
          .document('1')
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }
}