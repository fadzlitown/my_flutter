import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'counter_test_state.dart';

class CounterTestCubit extends Cubit<CounterTestState> with HydratedMixin {
  // final InternetCubit internetCubit;

  CounterTestCubit()
      : super(CounterTestState(
            counterValue: 0, wasIncremented: false, totalMultiplyByTwo: 0));

  // => equals to return
  void increment() {
    return emit(CounterTestState(
        counterValue: state.counterValue + 1,
        wasIncremented: true,
        totalMultiplyByTwo: state.totalMultiplyByTwo));
  }

  void decrement() => emit(CounterTestState(
      counterValue: state.counterValue - 1,
      wasIncremented: false,
      totalMultiplyByTwo: state.totalMultiplyByTwo));

  void clearValue() {
    return emit(CounterTestState(counterValue: 0, wasIncremented: false));
  }

  void multiply() {
    int total = state.counterValue * 2;
    return emit(CounterTestState(
        counterValue: state.counterValue,
        wasIncremented: true,
        totalMultiplyByTwo: total));
  }

  //every time trigger func / event & state update (rebuild UI)  this callback will be called
  /// NOTED !!!! ISSUE FOUND IN PACKAGE DEPENDENCY
  /// cannot used log() if implement with HydratedMixin
  // @override
  // void onChange(Change<CounterTestState> change) {
  //   log("CounterTestCubit: onChange");
  // }

  @override
  CounterTestState fromJson(Map<String, dynamic> json) {
    /// called everytime app needs stored data
    return CounterTestState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(CounterTestState state) {
    /// called for every states
    return state.toMap();
  }
}
