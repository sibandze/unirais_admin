import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class Resource<T> {
  final String url;
  final params;

  Resource({@required this.url, @required this.parse, this.params});

  T Function(http.Response response) parse;
}

class WebService {
  Future<T> get<T>(Resource resource) async {
    final response = await http.get(resource.url);
    switch (response.statusCode) {
      case 200:
        return resource.parse(response);
      default:
        throw Exception('Error');
    }
  }

  Future<T> delete<T>(Resource resource) async {
    final response = await http.delete(resource.url);
    switch (response.statusCode) {
      case 200:
        return resource.parse(response);
      default:
        throw Exception('Error');
    }
  }

  Future<T> post<T>(Resource resource) async {
    Map<String, String> headers = {
      "content-type": "application/x-www-form-urlencoded",
    };
    final response = await http.post(
      resource.url,
      headers: headers,
      body: resource.params,
    );
    switch (response.statusCode) {
      case 200:
        return resource.parse(response);
      default:
        throw Exception('Error');
    }
  }

  Future<T> put<T>(Resource resource) async {
    Map<String, String> headers = {
      "content-type": "application/x-www-form-urlencoded",
    };
    final response = await http.put(
      resource.url,
      headers: headers,
      body: resource.params,
    );
    switch (response.statusCode) {
      case 200:
        return resource.parse(response);
      default:
        throw Exception('Error');
    }
  }

  Future<T> patch<T>(Resource resource) async {
    Map<String, String> headers = {
      "content-type": "application/x-www-form-urlencoded",
    };
    final response = await http.patch(
      resource.url,
      headers: headers,
      body: resource.params,
    );
    switch (response.statusCode) {
      case 200:
        return resource.parse(response);
      default:
        throw Exception('Error');
    }
  }
}
