import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket? _socket;

  SocketService() {
    this._initConfig();
  }

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket? get socket => _socket;

  void _initConfig() {

    this._socket= IO.io('http://192.168.0.2:3000', {
      'transports': ['websocket'],
      'autoConnect': true
    });

    _socket!.onConnect((data) {
      print('connect');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket!.onDisconnect((_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });



  }
}
