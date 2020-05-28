import 'package:cardapio/models/produto_model.dart';
import 'package:cardapio/util/constantes.dart';
import 'package:dio/dio.dart';

class ProdutoService {
  final _dio = Dio(BaseOptions(baseUrl: URL_VIEW_PRODUTO));
  
  Future<List<ProdutoModel>> getProdutos() async {
    return [];
  }

  Future<ProdutoModel> getProduto() async{
    final resp = await _dio.get('5ecee1a13200004e00e3ce27');
    return ProdutoModel.fromJson(resp.data);
  }

  Future<ProdutoModel> criarProduto(ProdutoModel produto) async {
    return null;
  }


}