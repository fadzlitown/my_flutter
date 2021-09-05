import 'package:flutter_bloc/flutter_bloc.dart';

import 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  /// default SettingState values
  SettingCubit()
      : super(SettingState(appNotification: false, emailNotification: false));

  void toggleAppNotification(bool newVal) {
    ///COMMON ISSUE 1 : MUTATE A EXISTING STATE, YOU SHOULD NEVER MODIFY IT
    /// DART KNOWS THIS state IS THE SAME AS THE PREVIOUS EMITTED ONE!, can runs a project & test!
    // state.appNotification = newVal;
    // emit(state);
    emit(state.copyWith(appNotification: newVal));
  }

  void toggleEmailNotification(bool newVal) {
    emit(state.copyWith(emailNotification: newVal));
  }
}
