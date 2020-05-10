import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:guess_word_game/core/enums/connectivity_status.dart';

class ConnectivityService extends ChangeNotifier {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  Stream<ConnectivityStatus> get connectivity =>
      connectionStatusController.stream;

  ConnectivityService() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      connectionStatusController.add(_getStatusFromResult(result));
      if (result == ConnectivityResult.none) {
        print('No internet connection');
      } else {
        print('Connect change');
      }
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}
