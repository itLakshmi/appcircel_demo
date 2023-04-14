import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'ApiException.dart';


class ApiClient{

  Future<dynamic> fetchData(String url,Map<String, dynamic> params) async {

    var urlData = Uri.parse(url);
    print(url);
    print(params);
    var body = json.encode(params);
    print('\x1B[33m$body\x1B[0m');
    try{
      var response = await http.get(
          urlData,
          headers: <String, String>{
            "Content-Type": "application/json",
          },
      );
      print('\x1B[32m${response.body}\x1B[0m');

      return returnResponse(response);
    }on SocketException {
      throw FetchDataException('No Internet connection');
    }

  }


  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }
}

