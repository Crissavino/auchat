import 'dart:async';
import 'package:au_chat/models/user_model.dart';

class UserBloc {
  List<UserModel> usersToAddToGroup = List();

  final _usersController = StreamController<List<UserModel>>.broadcast();

  Stream<List<UserModel>> get usersStream => _usersController.stream;

  dispose() {
    _usersController?.close();
  }

  usersToAddSink(UserModel user) {
    usersToAddToGroup.add(user);
    _usersController.sink.add(usersToAddToGroup);
  }

  usersToRemoveStream(UserModel user) {
    usersToAddToGroup.removeWhere(
        (UserModel streamUser) => streamUser.firebaseId == user.firebaseId);
    _usersController.sink.add(usersToAddToGroup);
  }

  clearStream() {
    usersToAddToGroup = [];
    _usersController.sink.add(usersToAddToGroup);
  }
}
