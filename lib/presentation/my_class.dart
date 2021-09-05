import 'package:equatable/equatable.dart';

class MyClass extends Equatable {
  int val;

  // add [] -> to ignored the values of the obj between other obj
  // add [val] -> to compare the value of the obj between other obj
  @override
  List<Object> get props => [val];

  MyClass({this.val});
}

/// test this by clicking on the green run icon here
void main() {
  /// result
  final a = new MyClass(val: 1);
  final b = new MyClass(val: 2);
  //a == b false
  // a == a true
  // b == b true

  /// result
  // final a = new MyClass(val: 1);
  // final b = new MyClass(val: 1);
  //a == b true
  // a == a true
  // b == b true

  print("a == b " + (a == b).toString());
  print("a == a " + (a == a).toString());
  print("b == b " + (b == b).toString());
}
