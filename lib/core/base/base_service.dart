import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guess_word_game/core/config/app_config.dart';
import 'package:guess_word_game/ui/constants/app_value.dart';
import 'package:http/http.dart' as http;

import 'base_exception.dart';

abstract class BaseService {
  String _url(context, endpoint) => endpoint.startsWith('http')
      ? endpoint
      : '${AppConfig.of(context).apiBaseUrl}/$endpoint${endpoint.contains('?') ? '' : '/'}';

  Future<dynamic> get(BuildContext context, endpoint,
      {shouldSkipAuth = false}) async {
    var responseJson;
    try {
      final http.Response response = await http
          .get(_url(context, endpoint),
              headers: await _getHeader(shouldSkipAuth))
          .timeout(Duration(seconds: timeout_duration));
      responseJson = _returnResponse(context, response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(BuildContext context, endpoint,
      {data, shouldSkipAuth = false}) async {
    var responseJson;
    http.Response response;
    try {
      response = await http.Client()
          .post(
            _url(context, endpoint),
            body: json.encode(data),
            headers: await _getHeader(shouldSkipAuth),
          )
          .timeout(Duration(seconds: timeout_duration));
      responseJson = _returnResponse(context, response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _getHeader(shouldSkipAuth) async {
    final header = {"Content-Type": "application/json"};
    if (!shouldSkipAuth) {
      final apiToken = '';
      if (apiToken?.isNotEmpty == true) {
        header[HttpHeaders.authorizationHeader] = "Bearer $apiToken";
      }
    }
    return header;
  }

  dynamic _returnResponse(BuildContext context, http.Response response) async {
    switch (response.statusCode) {
      case 200:
        return 200;
        break;
      case 400:
        return 400;
      case 401:
        return 401;
      case 403:
        return 403;
      case 500:
      default:
        return 500;
    }
  }
}
