import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeButtonWidgets extends StatelessWidget {
  const LikeButtonWidgets({
    Key? key,
    required this.nameIcon,
    required this.icon,
    required this.likeCount,
  }) : super(key: key);
  final String nameIcon;
  final IconData icon;
  final int likeCount;

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: 30,
      circleColor:
          const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Color(0xff33b5e5),
        dotSecondaryColor: Color(0xff0099cc),
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          icon,
          color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
          size: 30,
        );
      },
      likeCount: likeCount,
      countBuilder: (int? count, bool isLiked, String text) {
        var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
        Widget result;
        if (count == 0) {
          result = Text(
            nameIcon,
            style: TextStyle(color: color),
          );
        } else {
          result = Text(
            text,
            style: TextStyle(color: color),
          );
        }
        return result;
      },
    );
  }
}
