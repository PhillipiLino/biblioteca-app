import 'package:biblioteca/core/http_client/http_client.dart';
import 'package:http/http.dart' as http;

class HttpImplementation implements HttpClient {
  final http.Client client;

  HttpImplementation(this.client);

  @override
  Future<HttpResponse> get(String url) async {
    final response = await client.get(Uri.parse(url));
    return HttpResponse(data: response.body, statusCode: response.statusCode);
  }

  @override
  Future<HttpResponse> post(
    String url, {
    required Map<String, dynamic> body,
  }) async {
    final response = await client.post(Uri.parse(url), body: body);
    return HttpResponse(data: response.body, statusCode: response.statusCode);
  }
}
