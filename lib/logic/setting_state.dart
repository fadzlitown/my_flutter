import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class SettingState extends Equatable {
  bool appNotification;
  bool emailNotification;

  SettingState(
      {@required this.appNotification, @required this.emailNotification});

  ///To create a new instance by copying the previous instance state
  SettingState copyWith({bool appNotification, bool emailNotification}) {
    return SettingState(
      ///fields you want to modify
      appNotification: appNotification ?? this.appNotification,
      emailNotification: emailNotification ?? this.emailNotification,
    );
  }

  /// COMMON MISTAKE 2: FORGET TO MENTION THE CORRECT PROPS VARIABLE BELOW --> props => [appNotification, emailNotification]
  /// Dart will compare based on variables that modify
  @override
  // List<Object> get props => [appNotification];
  List<Object> get props => [appNotification, emailNotification];
}
