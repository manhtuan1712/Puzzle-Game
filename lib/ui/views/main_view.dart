import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guess_word_game/core/base/base_view.dart';
import 'package:guess_word_game/core/router/router.dart';
import 'package:guess_word_game/core/util/utils.dart';
import 'package:guess_word_game/core/viewmodels/base_view_model.dart';
import 'package:guess_word_game/ui/constants/app_images.dart';
import 'package:guess_word_game/ui/widgets/tk_text.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  BaseViewModel _model;

  MobileAdTargetingInfo _mobileAdTargetingInfo;

  @override
  void initState() {
    _mobileAdTargetingInfo = MobileAdTargetingInfo(
      testDevices: <String>[],
      keywords: <String>['game', 'sport', 'girls'],
      childDirected: false,
    );
    RewardedVideoAd.instance.load(
        adUnitId: RewardedVideoAd.testAdUnitId,
        targetingInfo: _mobileAdTargetingInfo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<BaseViewModel>(
        model: BaseViewModel(context),
        onModelReady: (model) {
          _model = model;
          model.loadAsset();
        },
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Center(
                  child: TKText('Select Level', textAlign: TextAlign.center)),
            ),
            body: GridView.count(
                crossAxisCount: 2,
                children: _model.question.questions
                    .map((item) => Center(
                        child: GestureDetector(
                            onTap: () {
                              if (item.isLocked == 1) {
                                RewardedVideoAd.instance.listener =
                                    (RewardedVideoAdEvent event,
                                        {String rewardType,
                                        int rewardAmount}) async {
                                  if (event == RewardedVideoAdEvent.rewarded) {
                                    var db = await Utils.initDatabase();
                                    item.isLocked = 0;
                                    await Utils.updateQuestion(db, item);
                                    Navigator.pushNamed(context, Router.detail,
                                        arguments: item);
                                  } else if (event ==
                                      RewardedVideoAdEvent.closed) {
                                    RewardedVideoAd.instance.load(
                                        adUnitId: RewardedVideoAd.testAdUnitId,
                                        targetingInfo: _mobileAdTargetingInfo);
                                  } else {
                                    print('chưa xem lêu lêu');
                                  }
                                };
                                RewardedVideoAd.instance.show();
                              } else {
                                Navigator.pushNamed(context, Router.detail,
                                    arguments: item);
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: item.isLocked == 1
                                      ? DecorationImage(
                                          image: AssetImage(ic_locked_item),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                width: Utils.resizeWidthUtil(context,
                                    Utils.resizeWidthUtil(context, 150)),
                                height: Utils.resizeHeightUtil(context,
                                    Utils.resizeHeightUtil(context, 250)),
                                child: item.isLocked == 1
                                    ? Container()
                                    : Center(
                                        child: TKText(
                                        item.name,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline,
                                      ))))))
                    .toList())));
  }
}
