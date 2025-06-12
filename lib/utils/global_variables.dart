import 'package:flutter/material.dart';
import 'utils.dart';

String pieSocketUrl = '';
String clusterId = '';
String apiKey = '';

dynamic callTimeout = 30;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final socketService = SocketService();

final pieSocketService = PieSocketService();
