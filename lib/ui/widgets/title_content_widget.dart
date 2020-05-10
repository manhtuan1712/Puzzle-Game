import 'package:flutter/material.dart';
import 'package:guess_word_game/core/util/utils.dart';
import 'package:guess_word_game/ui/widgets/tk_text.dart';

titleContentWidget(BuildContext context, String title, String content,
    {EdgeInsets margin,
    EdgeInsets padding,
    Color color = Colors.white,
    bool isBold = true}) {
  return Container(
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(7)),
    margin: margin,
    padding: padding,
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: Utils.resizeHeightUtil(context, 20),
          alignment: Alignment.centerLeft,
          child: TKText(
            Utils.getString(context, title),
            style: TextStyle(
                color: Colors.grey,
                fontSize: Utils.resizeHeightUtil(context, 20) * 0.78),
          ),
        ),
        SizedBox(height: Utils.resizeHeightUtil(context, 5)),
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          child: TKText(
            content == null ? "" : content,
            style: TextStyle(fontSize: Utils.resizeHeightUtil(context, 20)),
            tkFont: isBold ? TKFont.BOLD : TKFont.REGULAR,
          ),
        )
      ],
    ),
  );
}
