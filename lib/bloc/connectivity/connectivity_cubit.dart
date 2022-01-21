import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityInitial());
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _notCon = ConnectivityResult.none;

  init() {
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  Future<void> close() async {
    _connectivitySubscription.cancel();
    super.close();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == _notCon) {
      emit(OnDisconnected());
    } else {
      emit(OnConnected());
    }
  }
}
