import 'package:flutter/material.dart';
import 'package:nextazy_task/Model/Response/NewData.dart';

import '../Model/ApiClient.dart';
import '../Model/ApiInterface.dart';
import '../Model/ApiResponse.dart';
import '../Model/Status.dart';




class HomeVM extends ChangeNotifier{

  final _myRepo = ApiInterface();
  final ApiClient _apiService = ApiClient();
  List<ListData> listOfData= [];
  String nextPage = "";
  ApiResponse<NewsData> dataConvert = ApiResponse.loading();

  ApiResponse<NewsData> get getData => dataConvert;


  setData(ApiResponse<NewsData> response) {
    print("Response :: $response");
    dataConvert = response;
    if(response.status == Status.completed){
      if(response.data!.data!.listData != null){
        List<ListData>? data1 = response.data!.data!.listData;
        nextPage = response.data!.data!.after.toString();
        listOfData = data1!;
      }else{
        listOfData = [];
      }

    }
    notifyListeners();
  }

  setDataNext(ApiResponse<NewsData> response) {
    print("Response :: $response");
    print(response.data);
    dataConvert = response;
    if(response.status == Status.completed){
      if(response.data!.data!.listData != null){
        print(response.data!.data!.listData!.length);
        List<ListData>? data1 = response.data!.data!.listData;
        nextPage = response.data!.data!.after.toString();
        listOfData.addAll(data1!);
      }
    }
    print(listOfData.length);
    notifyListeners();
  }

  Future<void> fetch(Map<String,dynamic> params,HomeVM model) async {
    model.setData( ApiResponse.loading());
    _myRepo.getNews(params,false,"")
        .then((value) {
      return model.setData( ApiResponse.completed(value));
    });
    //     .onError((error, stackTrace) {
    //   return model.setData(ApiResponse.error(error.toString()));
    // });
  }
  Future<void> fetchNext(Map<String,dynamic> params,HomeVM model) async {
    print(model.nextPage);
    _myRepo.getNews(params,true,model.nextPage)
        .then((value) {
      return model.setDataNext( ApiResponse.completed(value));
    });
  }


}