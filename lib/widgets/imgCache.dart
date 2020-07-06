import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImgCache extends StatelessWidget {
  final String img;

  const ImgCache({Key key, this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     
    return CachedNetworkImage(
      imageUrl: img,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(value: downloadProgress.progress),
          ),
      errorWidget: (context, url, error) => Icon(Icons.image),
    );
  }
}