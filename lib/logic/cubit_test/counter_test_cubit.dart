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

  CounterTestCubit({@required this.internetCubit})
      : super(CounterTestState(counterValue: 0, totalMultiplyByTwo: 0)) {
    /// need to subscribe InternetCubit (listen to it)
    monitorInternetCubit();
  }

  @override
  Future<Function> close() {
    streamSubscription.cancel();
    super.close();
  }

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

  //every time trigger func / event & state update (rebuild UI)  this callback will be called
  @override
  void onChange(Change<CounterTestState> change) {
    log("CounterTestCubit: onChange");
  }

  Future<StreamSubscription<InternetState>> monitorInternetCubit() async {
    streamSubscription = internetCubit.listen((state) {
      if (state is InternetConnected &&
          state.connectionType == ConnectionType.WIFI) {
        increment();
      } else if (state is InternetConnected &&
          state.connectionType == ConnectionType.MOBILE) {
        decrement();
      }
    });
  }
}
