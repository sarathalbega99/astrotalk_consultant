import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'utils.dart';

class SocketService {
  late io.Socket socket;

  // ✅ Add callbacks
  void Function()? onConnect;
  void Function(dynamic)? onError;
  void Function()? onDisconnect;
  void Function(dynamic)? onCallInitiated;
  void Function(dynamic)? onIncomingCall;
  void Function(dynamic)? onCallMissed;
  void Function(dynamic)? onCallCancelled;
  void Function(dynamic)? onCallDisconnect;
  void Function(dynamic)? onCallAccepted;
  void Function(dynamic)? onCallEnded;

  void Function(dynamic)? onActiveConsultants;

  void connectSocket(String token) {
    socket = io.io(
      'https://dev.bluepencils.co',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({'token': token})
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      if (onConnect != null) onConnect!();
    });

    // Listen for active_consultants event
    socket.on('active_consultants', (data) {
      if (onActiveConsultants != null) onActiveConsultants!(data);
    });

    socket.onConnectError((err) {
      log('Error from socket');
      if (onError != null) onError!(err);
    });

    socket.onDisconnect((_) {
      log('Disconnected from socket');
      if (onDisconnect != null) onDisconnect!();
    });

    socket.on('incoming_call', (data) async {
      
      if (onIncomingCall != null) onIncomingCall!(data);
    });

    socket.on('call_missed', (data) {
      log('call_missed: $data');
      if (onCallMissed != null) onCallMissed!(data);
    });

    socket.on('call_cancelled', (data) {
      log('call_cancelled: $data');
      if (onCallCancelled != null) onCallCancelled!(data);
    });

    // socket.on('call_initiated', (data) {
    //   log('call_initiated: $data');
    //   if (onCallInitiated != null) onCallInitiated!(data);
    // });

    socket.on('call_ended', (data) {
      log('call_ended: $data');
      if (onCallEnded != null) onCallEnded!(data);
    });
  }

  void disconnect() {
    socket.disconnect();
  }
}

class PieSocketService {
  WebSocketChannel? _channel;

  void connect({
    // String? clusterId,
    // String? apiKey,
    // String? jfwToken,
    // String? callId,
    void Function(dynamic data)? onMessage,
    void Function()? onDone,
    void Function(dynamic error)? onError,
  }) {
    final uri = Uri.parse(pieSocketUrl);

    log('Connecting to: $uri');

    _channel = WebSocketChannel.connect(uri);

    _channel!.stream.listen(
      (message) {
        log('Received: $message');
        if (onMessage != null) onMessage(message);
      },
      onDone: () {
        log('Connection closed.');
        if (onDone != null) onDone();
      },
      onError: (error) {
        log('Error: $error');
        if (onError != null) onError(error);
      },
    );
  }

  void disconnect() {
    _channel?.sink.close(status.normalClosure);
    log('Disconnected from PieSocket');
  }
}
