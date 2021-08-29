import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_test_state.dart';

class CounterTestCubit extends Cubit<CounterTestState> {
  CounterTestCubit()
      : super(CounterTestState(counterValue: 0, totalMultiplyByTwo: 0));

  void increment() => emit(CounterTestState(
      counterValue: state.counterValue + 1,
      wasIncremented: true,
      totalMultiplyByTwo: state.totalMultiplyByTwo));

  void decrement() => emit(CounterTestState(
      counterValue: state.counterValue - 1,
      wasIncremented: false,
      totalMultiplyByTwo: state.totalMultiplyByTwo));

  void multiply() {
    int total = state.counterValue * 2;
    return emit(CounterTestState(
        counterValue: state.counterValue,
        wasIncremented: true,
        totalMultiplyByTwo: total));
  }
}
