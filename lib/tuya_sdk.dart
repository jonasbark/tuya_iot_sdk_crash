// Autogenerated from Pigeon (v3.0.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name
// @dart = 2.12
import 'dart:async';
import 'dart:typed_data' show Uint8List, Int32List, Int64List, Float64List;

import 'package:flutter/foundation.dart' show WriteBuffer, ReadBuffer;
import 'package:flutter/services.dart';

class Device {
  Device({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['id'] = id;
    pigeonMap['name'] = name;
    return pigeonMap;
  }

  static Device decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return Device(
      id: pigeonMap['id'] as String?,
      name: pigeonMap['name'] as String?,
    );
  }
}

class PairingToken {
  PairingToken({
    this.token,
    this.pairingToken,
    this.region,
    this.secret,
  });

  String? token;
  String? pairingToken;
  String? region;
  String? secret;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['token'] = token;
    pigeonMap['pairingToken'] = pairingToken;
    pigeonMap['region'] = region;
    pigeonMap['secret'] = secret;
    return pigeonMap;
  }

  static PairingToken decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return PairingToken(
      token: pigeonMap['token'] as String?,
      pairingToken: pigeonMap['pairingToken'] as String?,
      region: pigeonMap['region'] as String?,
      secret: pigeonMap['secret'] as String?,
    );
  }
}

class _TuyaSdkCodec extends StandardMessageCodec {
  const _TuyaSdkCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is Device) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else 
    if (value is PairingToken) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else 
{
      super.writeValue(buffer, value);
    }
  }
  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:       
        return Device.decode(readValue(buffer)!);
      
      case 129:       
        return PairingToken.decode(readValue(buffer)!);
      
      default:      
        return super.readValueOfType(type, buffer);
      
    }
  }
}

class TuyaSdk {
  /// Constructor for [TuyaSdk].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  TuyaSdk({BinaryMessenger? binaryMessenger}) : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _TuyaSdkCodec();

  Future<void> init(String arg_appKey, String arg_appSecret, String arg_username, String arg_password) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.TuyaSdk.init', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_appKey, arg_appSecret, arg_username, arg_password]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<PairingToken> getPairingToken(String arg_assetId) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.TuyaSdk.getPairingToken', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_assetId]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as PairingToken?)!;
    }
  }

  Future<Device> connectToWifi(PairingToken arg_token, String arg_ssid, String arg_password) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.TuyaSdk.connectToWifi', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_token, arg_ssid, arg_password]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as Device?)!;
    }
  }
}
