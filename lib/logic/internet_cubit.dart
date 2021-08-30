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

  InternetCubit({@required this.connectivity}) : super(InternetLoader()){
    monitorInternetCubit();
  }

  @override
  Future<Function> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }

  StreamSubscription monitorInternetCubit() {
     return connectivityStreamSubscription = connectivity.onConnectivityChanged.listen((event) {
      if(event == ConnectionType.WIFI){
        emit(InternetConnected(connectionType: ConnectionType.WIFI));
      } else if (event == ConnectionType.MOBILE){
        emit(InternetConnected(connectionType: ConnectionType.MOBILE));
      } else if (event == ConnectionType.NONE){
        emit(InternetDisconnected());
      }
    });
  }
}
