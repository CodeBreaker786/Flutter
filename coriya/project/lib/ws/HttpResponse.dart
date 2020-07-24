import 'dart:convert';

class HttpResponse {
  bool success;
  dynamic response;
  String error;

  HttpResponse(this.success, this.response, this.error);

  @override
  String toString() {
    if (response is Map) {
      return json.encode(response);
    }
    return response.toString();
  }
}
