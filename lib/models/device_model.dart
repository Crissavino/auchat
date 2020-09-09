import 'dart:convert';

DeviceModel deviceModelFromJson(String str) =>
    DeviceModel.fromJson(json.decode(str));

String deviceModelToJson(DeviceModel data) => json.encode(data.toJson());

class DeviceModel {
  dynamic user;
  String deviceId;
  String type;
  String token;
  String language;
  List<String> deviceMessages;

  DeviceModel({
    this.user,
    this.deviceId,
    this.type,
    this.token,
    this.language,
    this.deviceMessages,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
        user: json["user"],
        deviceId: json["deviceId"],
        type: json["type"],
        token: json["token"],
        language: json["language"],
        deviceMessages: json["deviceMessages"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "deviceId": deviceId,
        "type": type,
        "token": token,
        "language": language,
        "deviceMessages": deviceMessages,
      };
}
