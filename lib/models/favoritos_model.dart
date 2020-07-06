import 'package:cardapio/models/produto_model.dart';

class FavoritosModel {
  String uid;
  List<String> estabs;
  List<String> produtos;

  FavoritosModel({this.uid, this.estabs, this.produtos});

  bool isProdFavorito(ProdutoModel estab) {}
}
