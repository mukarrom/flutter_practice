import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final String _tokenName = "token";

  String? token;

  Future<void> saveData(String accessToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenName, accessToken);
    token = accessToken;
  }

  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(_tokenName);
    return token;
  }

  Future<void> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_tokenName);
    token = null;
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(_tokenName);
    if (token != null) {
      return true;
    }
    return false;
  }
}
