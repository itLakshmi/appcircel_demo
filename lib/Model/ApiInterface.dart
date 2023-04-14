

import 'package:nextazy_task/Model/Response/NewData.dart';

import 'ApiClient.dart';
import 'Repository/Repo.dart';
import 'ServerURL.dart';

class ApiInterface implements Repo {

  final ApiClient _apiService = ApiClient();

  @override
  Future<NewsData?> getNews(Map<String, dynamic> params,bool isRefresh,String page) async {
    try {
      String url = isRefresh ? "${ServerURL.baseurl}&after=$page" : ServerURL.getUrl(RequestType.base);
      dynamic response = await _apiService.fetchData(url,params);
      print("Response $response");
      final jsonData = NewsData.fromJson(response);
      return jsonData;
    } catch (e) {
      print("Error $e");
      rethrow;
    }
  }




}