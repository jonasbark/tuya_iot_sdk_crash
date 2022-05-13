import 'package:pigeon/pigeon.dart';

class Device {
  String? id;
  String? name;
}

class PairingToken {
  String? token;
  String? pairingToken;
  String? region;
  String? secret;
}

@HostApi()
abstract class TuyaSdk {
  @async
  void init(String appKey, String appSecret, String username, String password);

  @async
  PairingToken getPairingToken(String assetId);

  @async
  Device connectToWifi(PairingToken token, String ssid, String password);
}
