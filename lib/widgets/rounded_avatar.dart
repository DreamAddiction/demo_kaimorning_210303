import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'my_progress_indicator.dart';

class RoundedAvatar extends StatelessWidget {

  final String imgUrl;
  final double size;

  RoundedAvatar({this.size=50.0, this.imgUrl = "https://firebasestorage.googleapis.com/v0/b/fir-practice-cfe9f.appspot.com/o/user%2Fcuya1.png?alt=media&token=6e23bbb3-73f4-4e7e-bc61-6e7f467d7fb6",
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          clipBehavior:  Clip.hardEdge,
          borderRadius: BorderRadius.all(Radius.circular(size*0.4)),
          child: Container(
            width: size + 2,
            height: size + 2,
            color: Colors.white,
          )
        ),
        ClipRRect(
          clipBehavior:  Clip.hardEdge,
          borderRadius: BorderRadius.all(Radius.circular(size*0.4)),
          child: CachedNetworkImage(
            placeholder: (context, url) => MyProgressIndicator(),
            imageUrl: imgUrl,
            width: size,
            height: size,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
