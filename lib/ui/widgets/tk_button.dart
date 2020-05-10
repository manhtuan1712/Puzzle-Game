import 'package:flutter/material.dart';
import 'package:guess_word_game/core/util/utils.dart';
import 'package:guess_word_game/ui/constants/app_colors.dart';
import 'package:guess_word_game/ui/widgets/tk_text.dart';

class TKButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final EdgeInsets margin;
  final Color borderColor;
  final Color textColor;
  final Color backgroundColor;
  final double width;
  final double height;
  final double borderRatio;

  TKButton(this.text,
      {this.onPress,
      this.margin,
      this.textColor = Colors.white,
      this.borderColor = Colors.transparent,
      this.width = 50,
      this.height = 50,
      this.borderRatio = 5.0,
      this.backgroundColor = button_color});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPress,
      child: Container(
        margin: margin,
        width: width,
        height: height,
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Center(
              child: TKText(
                text,
                tkFont: TKFont.BOLD,
                style: TextStyle(
                    color: textColor,
                    fontSize: Utils.resizeHeightUtil(
                        context, constraint.maxHeight * 0.4)),
              ),
            );
          },
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRatio),
            color: backgroundColor,
            border: Border.all(width: 1, color: borderColor)),
      ),
    );
  }
}
