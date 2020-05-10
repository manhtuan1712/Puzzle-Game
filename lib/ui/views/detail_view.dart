import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:guess_word_game/core/base/base_view.dart';
import 'package:guess_word_game/core/models/question.dart';
import 'package:guess_word_game/core/viewmodels/base_view_model.dart';
import 'package:guess_word_game/ui/constants/app_images.dart';
import 'package:guess_word_game/ui/widgets/app_bar_custom.dart';
import 'package:guess_word_game/ui/widgets/dialog_custom.dart';

class DetailView extends StatefulWidget {
  final Question question;

  const DetailView({this.question});

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> with TickerProviderStateMixin {
  BaseViewModel _model;

  TextEditingController answerController = TextEditingController();

  GifController controller;

  @override
  void initState() {
    controller = GifController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BaseViewModel>(
        model: BaseViewModel(context),
        onModelReady: (model) {
          _model = model;
        },
        builder: (context, model, child) => Scaffold(
            appBar: appBarCustom(context, () => {Navigator.pop(context)},
                () => {}, widget.question.name, null),
            body: SingleChildScrollView(
                child: Stack(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Image.network(widget.question.img),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            child: TextField(
                              controller: answerController,
                              onChanged: (string) {
                                if (widget.question.answer
                                        .toLowerCase()
                                        .indexOf(string) !=
                                    -1) {
                                  print('Yup');
                                } else {
                                  print('Not');
                                }
                              },
                              onSubmitted: (string) {
                                var _isCorrect = "";
                                if (widget.question.answer.toLowerCase() ==
                                    string) {
                                  _isCorrect = ic_true;
                                } else {
                                  _isCorrect = ic_false;
                                }
                                controller.repeat(
                                    min: 0,
                                    max: 70,
                                    period: Duration(milliseconds: 2000));
                                showCheckQuestionDialog(
                                    context, _isCorrect, controller);
                              },
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueAccent, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blueGrey, width: 2.0),
                                  ),
                                  hintText: 'Enter a answer here'),
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ))));
  }
}
