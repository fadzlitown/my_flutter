import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_practices/const/enums.dart';
import 'package:flutter_practices/logic/internet_cubit.dart';
import 'package:meta/meta.dart';

part 'counter_test_state.dart';

class CounterTestCubit extends Cubit<CounterTestState> {
  final InternetCubit internetCubit;
  StreamSubscription streamSubscription;

  CounterTestCubit({@required this.internetCubit}) :super(CounterTestState(counterValue: 0, totalMultiplyByTwo: 0)){
    /// need to subscribe InternetCubit (listen to it)
    streamSubscription = internetCubit.listen((curState) {
      if(curState is InternetConnected && curState.connectionType == ConnectionType.WIFI){
        increment();
      } else if(curState is InternetConnected && curState.connectionType == ConnectionType.MOBILE){
        decrement();
      }
    })
  };

  void increment() => emit(CounterTestState(
      counterValue: state.counterValue + 1,
      wasIncremented: true,
      totalMultiplyByTwo: state.totalMultiplyByTwo));

  void decrement() => emit(CounterTestState(
      counterValue: state.counterValue - 1,
      wasIncremented: false,
      totalMultiplyByTwo: state.totalMultiplyByTwo));

  void clearValue() {
    return emit(CounterTestState(
        counterValue: 0, wasIncremented: false, totalMultiplyByTwo: 0));
  }

  void multiply() {
    int total = state.counterValue * 2;
    return emit(CounterTestState(
        counterValue: state.counterValue,
        wasIncremented: true,
        totalMultiplyByTwo: total));
  }

  @override
  Future<Function> close() {
    /// everytime init the streamSubscription, then need to cancel it
    streamSubscription.cancel();
    log("CounterTestCubit: close");
    super.close()
  }

  //every time trigger func / event & state update (rebuild UI)  this callback will be called
  @override
  void onChange(Change<CounterTestState> change) {
    log("CounterTestCubit: onChange");
  }


}
