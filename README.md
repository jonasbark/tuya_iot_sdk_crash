flutter pub run pigeon \
--input api.dart \
--dart_out lib/tuya_sdk.dart \
--objc_header_out ios/Classes/TuyaSdk.h \
--objc_source_out ios/Classes/TuyaSdk.m \
--java_out ./android/src/main/java/io/fieldbots/tuya_sdk/TuyaSdkGenerated.java \
--java_package "io.fieldbots.tuya_sdk"
