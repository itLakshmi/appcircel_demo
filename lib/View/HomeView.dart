import 'package:flutter/material.dart';
import 'package:nextazy_task/View/DetailsView.dart';
import 'package:nextazy_task/ViewModel/HomeVM.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../Model/Status.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final HomeVM _api = HomeVM();

  fetchData(bool isRefresh){

    HomeVM model = Provider.of<HomeVM>(context, listen: false);
    Map<String,dynamic> params ={
      "after": "",
    };

    if(isRefresh){
      _api.fetchNext(params, model);
    }else{
      _api.fetch(params,model);
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    fetchData(false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        elevation: 0,
        title: const Text("News Feed",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      body: Consumer<HomeVM>(builder: (context, viewModel, _) {
        switch (viewModel.getData.status) {
          case Status.loading:
            return  const Center(child: CircularProgressIndicator(color: Colors.white,));
          case Status.error:
            return const Center(child: Center(child: Text("Something Issue"),))  ;
          case Status.completed:
            var VM = viewModel.listOfData;
            return
              VM.isEmpty ?
              const Center(child:Center(child: Text("No Record Found",style: TextStyle(fontWeight: FontWeight.bold),),)) :
              SmartRefresher(
                controller: _refreshController,
                enablePullDown: false,
                enablePullUp: true,
                onRefresh: () {},
                onLoading: () {
                  fetchData(true);
                  _refreshController.loadComplete();
                },
                child: ListView.builder(
                  itemCount: viewModel.listOfData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsView(data: viewModel.listOfData[index])));
                        },
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 10,),
                              SizedBox(
                                  height: 130,
                                  width: 80,
                                  child:  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child:
                                     Image.network(
                                      viewModel.listOfData[index].details!.thumbnail.toString(),
                                      fit: BoxFit.cover,
                                       errorBuilder: (BuildContext context, object ,  stackTrace) {
                                         return const Center(child: Icon(Icons.error,color: Colors.orangeAccent,),);
                                       },
                                    )
                                  )
                              ),
                              const SizedBox(width: 17,),
                              Container(
                                  height: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: 180,
                                          child: Text(viewModel.listOfData[index].details!.title.toString(),style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.w500,fontSize: 16),overflow: TextOverflow.ellipsis,maxLines: 5,)),
                                    ],
                                  )
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 30,
                                child: Center(
                                  child:CircleAvatar(
                                      backgroundColor: Colors.grey[200],
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.thumb_up_alt_outlined,color: Colors.orangeAccent,size: 17,),
                                          // Text(viewModel.listOfData[index].details!.likes.toString() == "null" ? "0" : viewModel.listOfData[index].details!.likes.toString() ,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600)),

                                        ],
                                      )) ,
                                ),
                              ),
                              const SizedBox(width: 8,),
                            ],
                          ),

                        ),
                      ),
                    );
                  },
                ),
              );
          default:
        }
        return Container();
      }),

    );
  }
}
