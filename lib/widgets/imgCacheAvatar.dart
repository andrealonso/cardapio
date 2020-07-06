import 'package:cached_network_image/cached_network_image.dart';
import 'package:cardapio/util/constantes.dart';
import 'package:flutter/material.dart';

class ImgCacheAvatar extends StatelessWidget {
  final String img;

  const ImgCacheAvatar({Key key, this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: img,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: imageProvider != null
            ? imageProvider
            : NetworkImage(imageAvatarPadrao),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(value: downloadProgress.progress),
      ),
      errorWidget: (context, url, error) => Icon(Icons.image),
    );
  }
}
