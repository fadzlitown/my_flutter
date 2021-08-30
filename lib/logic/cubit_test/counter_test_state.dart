part of 'counter_test_cubit.dart';

class CounterTestState {
  int counterValue;
  bool wasIncremented;
  int totalMultiplyByTwo;

  // {} constructor makes the argument a named optional argument.
  // without {} the argument would be mandatory
  // with [] the argument would be an optional positional argument
  CounterTestState(
      {@required this.counterValue,
      this.wasIncremented,
      this.totalMultiplyByTwo});
}
