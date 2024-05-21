import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:queue_ease/src/models/request.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../utils/http/http_client.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() => _instance;
  SocketService._internal();

  late io.Socket socket;

  static final StreamController<List<String?>> _activeUsersStreamController = StreamController<List<String?>>.broadcast();
  static Stream<List<String?>> get activeUsersStream => _activeUsersStreamController.stream;

  static final StreamController<Request> _newRequestStreamController = StreamController<Request>.broadcast();
  static Stream<Request> get newRequestStream => _newRequestStreamController.stream;

  void initialize() {
    socket = io.io(QEHttpHelper.baseURL, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      socket.emit('joinRoom', Hive.box('user').get('user')['_id']);
      debugPrint('Connected to socket');
    });

    socket.onDisconnect((_) {
      debugPrint('Disconnected from socket');
    });

    socket.on('connect_error', (data) {
      debugPrint('Connection error: $data');
    });

    socket.on('connect_timeout', (data) {
      debugPrint('Connection timeout: $data');
    });

    socket.on('error', (data) {
      debugPrint('Error: $data');
    });

    socket.on('reconnect', (data) {
      debugPrint('Reconnected to socket');
    });

    if (Hive.box('user').get('user')['isAgent'] == true) {
      socket.on('newRequest', (data) {
        _newRequestStreamController.add(Request.fromJson(data));
      });
    }
  }

  void listen(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }

  void removeListener(String event) {
    socket.off(event);
  }

  void emit(String event, [dynamic data]) {
    socket.emit(event, data);
  }
}
