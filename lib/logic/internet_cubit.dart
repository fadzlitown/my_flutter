import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_practices/const/enums.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

/// README: Cubit communication flow !!!!
/// COUNTER CUBIT -> depends -> Internet CUBIT -> depends -> Connectivity Library
/// tips: if any library did not depends on anyone. then SHOULD MOVE TO APP MAIN LEVEL eg. Connectivity Library
class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription connectivityStreamSubscription;

  InternetCubit({@required this.connectivity}) : super(InternetLoader()) {
    monitorInternetConnection();
  }

  @override
  Future<Function> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emit(InternetConnected(connectionType: ConnectionType.WIFI));
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emit(InternetConnected(connectionType: ConnectionType.MOBILE));
      } else if (connectivityResult == ConnectivityResult.none) {
        emit(InternetDisconnected());
      }
    });
  }
}
