part of 'connectivity_cubit.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class ConnectivityInitial extends ConnectivityState {}
class OnConnected extends ConnectivityState {}
class OnDisconnected extends ConnectivityState {}
