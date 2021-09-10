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

  Map<String, dynamic> toMap() {
    return {
      'counterValue': counterValue,
      'wasIncremented': wasIncremented,
      'totalMultiplyByTwo': totalMultiplyByTwo
    };
  }

  factory CounterTestState.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CounterTestState(
        counterValue: map['counterValue'],
        wasIncremented: map['wasIncremented'],
        totalMultiplyByTwo: map['totalMultiplyByTwo']);
  }

  String toJson() => json.encode(toMap());

  factory CounterTestState.fromJson(String source) =>
      CounterTestState.fromMap(json.decode(source));
}
