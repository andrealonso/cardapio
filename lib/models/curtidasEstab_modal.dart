import 'package:cardapio/models/usuario_modal.dart';

class CurtidaModel {
  String uid;
  String nome;
  String img;

  CurtidaModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    nome = json["nome"];
    img = json["img"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["uid"] = uid;
    data["nome"] = nome;
    data["img"] = img;
    return data;
  }
}
