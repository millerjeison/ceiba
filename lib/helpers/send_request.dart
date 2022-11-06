import 'dart:convert';

import 'package:http/http.dart';

import 'http_method.dart';

dynamic _parseBody(dynamic body) {
  try {
    return jsonEncode(body);
  } catch (e) {
    return body;
  }
}

Future<Response> sendRequest(
    {required Uri url,
    required Map<String, String> headers,
    required HttpMethod method,
    required dynamic body,
    required Duration timeout}) {
  var finalHeaders = {...headers};

  if (method != HttpMethod.get) {
    final contentType = headers["Content-Type"];

    if (contentType == null || contentType.contains("application/json")) {
      finalHeaders["Content-Type"] = "application/json; charset=UTF-8";
      body = _parseBody(body);
    }
  }

  final client = Client();
  switch (method) {
    case HttpMethod.get:
      return client.get(url, headers: finalHeaders).timeout(timeout);
    case HttpMethod.post:
      return client
          .post(url, body: body, headers: finalHeaders)
          .timeout(timeout);
    case HttpMethod.put:
      return client
          .post(url, body: body, headers: finalHeaders)
          .timeout(timeout);
    case HttpMethod.patch:
      return client
          .post(url, body: body, headers: finalHeaders)
          .timeout(timeout);
    case HttpMethod.delete:
      return client
          .post(url, body: body, headers: finalHeaders)
          .timeout(timeout);
  }
}
