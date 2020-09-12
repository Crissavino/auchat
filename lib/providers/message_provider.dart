import 'dart:convert';
import 'package:au_chat/models/device_message_model.dart';
import 'package:au_chat/models/message_model.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:http/http.dart' as http;

class MessageProvider {
  final String _url = '$NGROK_HTTP/api/messages';

  Future<List<DeviceMessageModel>> newMessage(
      MessageModel message, UserModel user) async {
    final url = '$_url/create/?firebaseId=${user.firebaseId}';

    final resp = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: messageModelToJson(message));

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData == null) return null;
    if (decodedData['response']['success'] != true) return null;

    final myLasDeviceMessagesFromNode =
        decodedData['response']['allMyDeviceMessages'];

    // return DeviceMessageModel.fromJson(myLasDeviceMessageFromNode);

    List<DeviceMessageModel> deviceMessages = List();
    myLasDeviceMessagesFromNode.forEach((value) {
      final message = DeviceMessageModel.fromJson(value);
      deviceMessages.add(message);
    });

    print(deviceMessages);

    return deviceMessages;
  }
}
