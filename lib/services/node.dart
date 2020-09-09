import 'dart:convert';
import 'package:au_chat/models/user_model.dart';
import 'package:au_chat/utilities/constants.dart';
import 'package:http/http.dart' as http;

class NodeService {
  final String _url = '$NGROK_HTTP/api';

  getAllUsers() async {
    final url = '$_url/getAllUsers';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    if (decodedData == null) return [];
    if (decodedData['error'] != null) return [];

    final usersFromNode = decodedData['users'];
    List<UserModel> users = List();

    usersFromNode.forEach((value) {
      final user = UserModel.fromJson(value);
      users.add(user);
    });
    return users;

    // decodedData.forEach((id, product) {
    //   final prodTemp = ProductModel.fromJson(product);
    //   prodTemp.id = id;

    //   products.add(prodTemp);
    // });

    // return products;
  }

  Future<UserModel> createUser(
      String firebaseId, String fullName, String email) async {
    final url = '$_url/user/create';

    final user = UserModel(
      firebaseId: firebaseId,
      fullName: fullName,
      email: email,
    );

    final resp = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: userModelToJson(user));

    final decodedData = json.decode(resp.body);

    final UserModel userFromMongo = userModelFromJson(decodedData['user']);

    return userFromMongo;
  }

  Future<UserModel> getUserByFirebaseId(String firebaseId) async {
    final url = '$_url/getUserByFirebaseId?firebaseId=$firebaseId';
    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);
    if (decodedData == null) return null;
    if (decodedData['error'] != null) return null;

    final userFromMongo =
        userModelFromJson(json.encode(decodedData['user'][0]));

    return userFromMongo;

    // decodedData.forEach((id, product) {
    //   final prodTemp = ProductModel.fromJson(product);
    //   prodTemp.id = id;

    //   products.add(prodTemp);
    // });

    // return products;
  }
}
