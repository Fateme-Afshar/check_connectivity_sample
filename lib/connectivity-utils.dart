import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityStatusListener {
  static final StreamController<NetworkStatus> networkStatusController =
      StreamController.broadcast();

  static void connectivityListener() {
    Connectivity().onConnectivityChanged.listen((event) {
      sendConnectivityStatusEvent(event);
    });
  }

  static void checkConnectivityFirstTime() {
    Connectivity().checkConnectivity().asStream().first.then((event) {
      sendConnectivityStatusEvent(event);
    });
  }

  static void sendConnectivityStatusEvent(ConnectivityResult event) {
    if (event == ConnectivityResult.mobile ||
        event == ConnectivityResult.wifi ||
        event == ConnectivityResult.ethernet ||
        event == ConnectivityResult.vpn) {
      networkStatusController.sink.add(NetworkStatus.ONLINE);
    } else {
      networkStatusController.sink.add(NetworkStatus.OFFLINE);
    }
  }

  static void close() {
    networkStatusController.close();
  }
}

enum NetworkStatus { ONLINE, OFFLINE, INITIAL }
