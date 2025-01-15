import 'dart:convert';

import 'package:click_mart_ecommerce_app/services/network_response.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkCaller {
  final Logger _logger = Logger();

  Future<NetworkResponse> getRequest(String url, {String? accessToken}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'content-type': 'application/json',
      };
      if (accessToken != null) {
        headers['token'] = accessToken;
      }
      _logRequest(url, headers);
      Response response = await get(uri, headers: headers);
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200) {
        final decodedMessage = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedMessage,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, '', e.toString());
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body, String? accessToken}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'content-type': 'application/json',
      };
      if (accessToken != null) {
        headers['token'] = accessToken;
      }
      _logRequest(url, headers);
      Response response =
          await post(uri, headers: headers, body: jsonEncode(body));
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200) {
        final decodedMessage = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedMessage,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, '', e.toString());
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  void _logRequest(String url, [Map<String, String>? headers, String? body]) {
    _logger.i('URL => $url\nHEADERS => $headers\nBODY => $body');
  }

  void _logResponse(
      String url, int statusCode, Map<String, String>? headers, String body,
      [String? errorMessage]) {
    if (errorMessage != null) {
      _logger.e('URL => $url\nERROR MESSAGE => $errorMessage');
    } else {
      _logger.i(
          'URL => $url\nSTATUS CODE => $statusCode\nHEADERS => $headers\nBODY => $body');
    }
  }
}
