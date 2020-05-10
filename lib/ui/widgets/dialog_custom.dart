import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:guess_word_game/core/util/utils.dart';
import 'package:guess_word_game/ui/constants/app_colors.dart';
import 'package:guess_word_game/ui/constants/app_images.dart';
import 'package:guess_word_game/ui/constants/app_strings.dart';
import 'package:guess_word_game/ui/widgets/tk_button.dart';
import 'package:guess_word_game/ui/widgets/tk_text.dart';

showLoadingDialog(BuildContext context) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: () async => false,
          child:
              SimpleDialog(backgroundColor: Colors.black54, children: <Widget>[
            Center(
              child: Column(children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                TKText(
                  Utils.getString(context, txt_waiting),
                  style: TextStyle(color: Colors.blueAccent),
                )
              ]),
            )
          ]));
    });

showMessageDialog(BuildContext context,
        {String title = 'Thông báo',
        String description = '',
        Function onPress,
        Function onPressX,
        Widget childContent,
        String buttonText = txt_ok}) =>
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                elevation: 0.0,
                backgroundColor: Colors.white,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TKText(title,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                              tkFont: TKFont.MEDIUM),
                          description.isEmpty
                              ? childContent
                              : Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TKText(
                                    description,
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                          TKButton(Utils.getString(context, buttonText),
                              width: MediaQuery.of(context).size.width * 0.3,
                              backgroundColor: button_login_on_boarding_end,
                              margin: EdgeInsets.only(top: 15),
                              onPress: onPress != null
                                  ? onPress
                                  : () => Navigator.pop(context)),
                        ],
                      ),
                    ),
                    Positioned(
                        right: 10,
                        top: 10,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: onPressX != null
                              ? onPressX
                              : () => Navigator.pop(context),
                          child: Icon(
                            Icons.clear,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ))
                  ],
                ),
              ),
              onWillPop: () async => false);
        });

showCheckQuestionDialog(
        BuildContext context, String isCorrect, GifController controller) =>
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          int duration = isCorrect == ic_true ? 2100 : 1950;
          Future.delayed(Duration(milliseconds: duration), () {
            controller.stop();
            Navigator.pop(context);
          });
          return WillPopScope(
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                elevation: 0.0,
                backgroundColor: Colors.white,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GifImage(
                              controller: controller,
                              image: AssetImage(isCorrect),
                            )
                          ]),
                    )
                  ],
                ),
              ),
              onWillPop: () async => false);
        });
