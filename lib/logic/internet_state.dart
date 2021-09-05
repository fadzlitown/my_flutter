part of 'internet_cubit.dart';

@immutable
abstract class InternetState {}

/// README: Before start with a state logic, we need to think
/// 1. How many available states ?
///   - Connected, Disconnected & Loading (to listen the connection)
///2. What are the properties involved ?
///  - type of Connectivity of your phone

class InternetLoader extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;

  InternetConnected({@required this.connectionType});
}

class InternetDisconnected extends InternetState {}
