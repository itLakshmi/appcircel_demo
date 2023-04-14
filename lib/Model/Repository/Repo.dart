import 'package:nextazy_task/Model/Response/NewData.dart';
import '../Response/BaseData.dart';

abstract class Repo{


  Future<NewsData?> getNews(Map<String,dynamic> params,bool isRefresh,String page) async {
    return null;
  }


}