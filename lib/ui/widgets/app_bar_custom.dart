import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guess_word_game/core/util/utils.dart';
import 'package:guess_word_game/ui/constants/app_colors.dart';
import 'package:guess_word_game/ui/constants/text_styles.dart';
import 'package:guess_word_game/ui/widgets/tk_text.dart';

const double app_bar_icon_size = 24;
const double app_bar_font_size = 16;
const double app_bar_height_size = 50;

Widget appBarCustom(BuildContext context, Function leftPress,
        Function rightPress, String title, IconData icon) =>
    PreferredSize(
        preferredSize: Size.fromHeight(
            Utils.resizeHeightUtil(context, app_bar_height_size)),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.blue, Colors.blue])),
          ),
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
            onTap: leftPress,
            child: Icon(
              Icons.arrow_back,
              color: icon_app_bar_color,
              size: Utils.resizeWidthUtil(context, app_bar_icon_size),
            ),
          ),
          title: TKText(title,
              style: appBarTextStyle(
                  Utils.resizeWidthUtil(context, app_bar_font_size))),
          actions: <Widget>[
            InkWell(
              child: Icon(icon ?? icon,
                  color: icon_app_bar_color,
                  size: Utils.resizeWidthUtil(context, app_bar_icon_size)),
              onTap: rightPress,
            ),
            Container(
              width: 10.0,
            )
          ],
        ));
