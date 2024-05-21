import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../connectivity-utils.dart';

class CheckInternetConnection extends StatelessWidget {

  const CheckInternetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ConnectivityStatusListener.networkStatusController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            switch (snapshot.data!) {
              case NetworkStatus.INITIAL:
                return const SizedBox.shrink();
              case NetworkStatus.ONLINE:
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                  showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        title: Text(
                          'You are online',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ));
                });
                break;
              case NetworkStatus.OFFLINE:
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                  showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                            title: Text(
                              'You are offline',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ));
                });
                break;
            }
          }
          return const Text("");
        });
  }
}
