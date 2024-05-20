import 'package:chat/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  static const String baseUrl = "http://localhost:3000/user";

  static Future<User?> fetchUserById(int userId) async {
    var url = Uri.parse('$baseUrl/getUserById/$userId');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        print('Failed to load user');
        return null;
      }
    } catch (e) {
      print('Error occurred while fetching user: $e');
      return null;
    }
  }
}
