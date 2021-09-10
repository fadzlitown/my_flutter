import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'counter_test_state.dart';

class CounterTestCubit extends Bloc<CounterTestState> with HydratedMixin {
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

  /// by triggering multiply() there's no crashing or error screen
  void multiply() {
    int total = state.counterValue * 2;
    addError(Exception("Could not write to storate!"), StackTrace.current);
    return emit(CounterTestState(
        counterValue: state.counterValue,
        wasIncremented: true,
        totalMultiplyByTwo: total));
  }

  //every time trigger func / event & state update (rebuild UI)  this callback will be called
  /// A change occurs when a new state is emitted. onChange is called before the state of the cubit is updated.
  /// onChange is a great spot to add logging/analytics for a specific cubit
  @override
  void onChange(Change<CounterTestState> change) {
    print("CounterTestCubit: onChange");
    super.onChange(change);
  }

  ///Called whenever an error occurs within a Cubit.
  ///By default all errors will be ignored and Cubit functionality will be unaffected
  @override
  void onError(Object error, StackTrace stackTrace) {
    print("$error, $stackTrace");
    super.onError(error, stackTrace);
  }

  ///This debug method will be available only if this class extends to Bloc
  // @override
  // void onTransition(Transition<Event, State> transition) {
  //   super.onTransition(transition);
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
