import 'dart:async';
import 'package:au_chat/models/chat_room_model.dart';
import 'package:au_chat/models/device_message_model.dart';
import 'package:au_chat/models/message_model.dart';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/services/chat_room.dart';
import 'package:au_chat/services/node.dart';

class UserBloc {
  List<UserModel> usersToAddToGroup = List();

  final _usersController = StreamController<List<UserModel>>.broadcast();

  Stream<List<UserModel>> get usersStream => _usersController.stream;

  // Function(List<UserModel>) get usersToAddSink => _usersController.sink.add;

  dispose() {
    _usersController?.close();
  }

  usersToAddSink(UserModel user) {
    usersToAddToGroup.add(user);
    _usersController.sink.add(usersToAddToGroup);
  }

  usersToRemoveStream(UserModel user) {
    usersToAddToGroup.removeWhere(
        (UserModel streamUser) => streamUser.fullName == user.fullName);
    _usersController.sink.add(usersToAddToGroup);
  }

  clearStream() {
    usersToAddToGroup = [];
    _usersController.sink.add(usersToAddToGroup);
  }
}
