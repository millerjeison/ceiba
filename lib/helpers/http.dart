import 'package:ceiba/helpers/http_result.dart';
import 'package:ceiba/helpers/parse_response_body.dart';

import 'http_method.dart';
import 'send_request.dart';

typedef Parser<T> = T Function(dynamic data);

class Http {
  final String baseUrl;

  Http({this.baseUrl = "https://jsonplaceholder.typicode.com"});

  Future<HttpResult<T>> request<T>(String path,
      {HttpMethod method = HttpMethod.get,
      Map<String, String> headers = const {},
      Map<String, String> queryParameters = const {},
      dynamic body,
      Parser<T>? parser,
      Duration timeout = const Duration(seconds: 10)}) async {
    int? statusCode;
    dynamic data;
    try {
      late Uri url;

      if (path.startsWith("http://") || path.startsWith("https://")) {
        url = Uri.parse(path);
      } else {
        url = Uri.parse("$baseUrl$path");
      }
      if (queryParameters.isNotEmpty) {
        url = url.replace(
            queryParameters: {...url.queryParameters, ...queryParameters});
      }

      final response = await sendRequest(
        url: url,
        headers: headers,
        method: method,
        body: body,
        timeout: timeout,
      );

      data = parseResponseBody(response.body);

      statusCode = response.statusCode;

      if (statusCode >= 400) {
        throw HttpError(
          data: data,
          stackTrace: StackTrace.current,
          exception: null,
        );
      }

      return HttpResult<T>(
          data: parser != null ? parser(data) : data,
          statusCode: statusCode,
          error: null);
    } catch (e, s) {
      if (e is HttpError) {
        return HttpResult<T>(
          data: null,
          error: e,
          statusCode: statusCode!,
        );
      }

      return HttpResult<T>(
        data: null,
        error: HttpError(
          data: data,
          exception: e,
          stackTrace: s,
        ),
        statusCode: statusCode ?? -1,
      );
    }
  }
}
