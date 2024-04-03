import 'package:socket_io_client/socket_io_client.dart';
import '../config/app_config.dart';

Socket socket = io(AppConfig.serverUrl, <String, dynamic>{
  "transports": ["websocket"],
  "autoConnected":false
});
