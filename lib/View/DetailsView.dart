import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nextazy_task/Model/Response/NewData.dart';



class DetailsView extends StatefulWidget {
  final ListData data;
  const DetailsView({Key? key, required this.data}) : super(key: key);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black54,
        // appBar: AppBar(
        //   backgroundColor: Colors.black54,
        //   elevation: 0,
        //   leading: InkWell(
        //       onTap: (){
        //         Navigator.pop(context);
        //       },
        //       child: const Icon(Icons.arrow_back,color: Colors.white,)),
        // ),
         body: Column(
           children: [
             Expanded(
               flex: 1,
                 child: Container(
                   // decoration: BoxDecoration(
                   //     borderRadius:
                   // ),
                   child: Stack(
                     children: [
                       Align(
                         alignment: Alignment.center,
                         child: Image.network(
                           height: height* 0.5,
                           width:width,
                           widget.data.details!.thumbnail.toString(),
                           fit: BoxFit.cover,
                           errorBuilder: (BuildContext context, object ,  stackTrace) {
                             return const Center(child: Icon(Icons.error,color: Colors.orangeAccent,),);
                           },
                         ),
                       ),
                       Align(
                         alignment: Alignment.topLeft,
                         child: InkWell(
                             onTap: (){
                               Navigator.pop(context);
                             },
                             child:const Padding(
                               padding:  EdgeInsets.all(8.0),
                               child:  Icon(Icons.arrow_back,color: Colors.white,),
                             )),
                       )
                     ],
                   ),
             )),
             Expanded(
                 flex: 1,
                 child: Column(
                   children:  [
                     SizedBox(height: height * 0.02,),
                     Row(
                       children: [
                         SizedBox(width: width * 0.04,),
                         const Text("Title",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                       ],
                     ),
                     SizedBox(height: height * 0.01,),
                     Row(
                       children: [
                         SizedBox(width: width * 0.04,),
                         SizedBox(
                             width:width * 0.8 ,

                             child: Text(widget.data.details!.title.toString(),style: const TextStyle(color: Colors.white,fontSize: 13),maxLines: 6,overflow: TextOverflow.ellipsis,)),
                       ],
                     ),
                     Visibility(
                       visible:widget.data.details!.selftext.toString() != "" ,
                       child: Column(
                         children: [
                           SizedBox(height: height * 0.01,),
                           Row(
                             children: [
                               SizedBox(width: width * 0.04,),
                               const Text("About",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

                             ],
                           ),
                           SizedBox(height: height * 0.01,),
                           Row(
                             children: [
                               SizedBox(width: width * 0.04,),
                               SizedBox(
                                   width:width * 0.8 ,

                                   child: Text(widget.data.details!.selftext.toString(),style: const TextStyle(color: Colors.white,fontSize: 13),maxLines: 6,overflow: TextOverflow.ellipsis,)),
                             ],
                           ),
                         ],
                       ),
                     ),
                     SizedBox(height: height * 0.01,),
                     Row(
                       children: [
                         SizedBox(width: width * 0.04,),
                         Text(convertDate(widget.data.details!.created!.toInt()) ,style: TextStyle(color: Colors.white,fontSize: 10),),
                       ],
                     )
                   ],
                 ))
           ],
         ),

      ),
    );
  }
  String convertDate( date) {
    DateTime date1 = DateTime.fromMicrosecondsSinceEpoch(date * 1000);
    String d = DateFormat('MMM dd,yyyy hh:mm a').format(date1);
    return d;
  }
}
