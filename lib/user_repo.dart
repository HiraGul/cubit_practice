import 'dart:io';

import 'package:cubit_practice/cubit/user_controller.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class UserRepository {
  static Future<int?> fetchUserData() async {
    try {
      var request =
          http.Request('GET', Uri.parse('https://reqres.in/api/users?page=2'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        UserDataController.userModelClass =
            userModelClassFromJson(await response.stream.bytesToString());
      } else {}
      return 404;
    } on SocketException {
      return 501;
    }
  }
}
