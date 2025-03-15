import 'dart:convert';

import 'package:basic_test/controllers/auth_controller.dart';
import 'package:basic_test/services/network_response.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkCaller {
  final Logger _logger = Logger();
  Future<NetworkResponse> getRequest(String url, {String? accessToken}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {'content-type': 'application/json'};
      if (accessToken != null) {
        headers['token'] = accessToken;
      }
      _logRequest(url, headers);
      final response = await http.get(uri, headers: headers);
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, "", e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  // post request
  Future<NetworkResponse> postRequest(
    String url,
    Map<String, dynamic>? body,
  ) async {
    try {
      /// uri
      Uri uri = Uri.parse(url);

      /// headers
      final headers = {"Content-Type": "application/json"};

      /// Auth token in headers if it is not null
      if (await AuthController().getToken() != null) {
        headers['token'] = (await AuthController().getToken())!;
      }
      _logRequest(url, headers, body);

      /// post request
      http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _logResponse(url, response.statusCode, response.headers, response.body);

      /// if status code is 200 or 201
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        /// if status code is not 200 or 201
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, "", e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  // patch request
  Future<NetworkResponse> patchRequest(
    String url,
    Map<String, dynamic>? body,
  ) async {
    try {
      Uri uri = Uri.parse(url);
      final headers = {"Content-Type": "application/json"};
      if (await AuthController().getToken() != null) {
        headers['token'] = (await AuthController().getToken())!;
      }
      _logRequest(url, headers, body);
      http.Response response = await http.patch(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, "", e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  // delete request
  Future<NetworkResponse> deleteRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      final headers = {"Content-Type": "application/json"};
      if (await AuthController().getToken() != null) {
        headers['token'] = (await AuthController().getToken())!;
      }
      _logRequest(url, headers);
      http.Response response = await http.delete(uri, headers: headers);
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, "", e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  void _logRequest(
    String url, [
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  ]) {
    _logger.i(
      "Request URL => $url\nRequest Header => $headers\nRequest Body => $body",
    );
  }

  void _logResponse(
    String url,
    int statusCode,
    Map<String, dynamic>? headers,
    String body, [
    String? errorMessage,
  ]) {
    if (errorMessage != null) {
      _logger.e(
        "Url => $url\nResponse Status Code => $statusCode\nResponse Error Message => $errorMessage",
      );
    } else {
      _logger.i(
        "Url => $url\nResponse Status Code => $statusCode\nResponse Headers => $headers\nResponse Body => $body",
      );
    }
  }
}
