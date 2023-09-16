import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/catagoriesModel.dart';


import '../view_model/news_view_model.dart';
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  String categoryname ="general";
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMM dd,yyyy');
  List<String> categoryList=[
    'General',
    'Entertainment',
    'Health',
    'Sports'
    'Business',
    'Technology'

  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  itemBuilder: (context,index){
                return InkWell(
                  onTap: (){
                    categoryname=categoryList[index];
                    setState(() {

                    });
                  },
                  child: Padding(padding: EdgeInsets.only(right: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: categoryname==categoryList[index]?Colors.blue : Colors.grey,
                    ),
                    child: Padding(
                        padding:EdgeInsets.symmetric(horizontal: 12),
                        child: Center(child: Text(categoryList[index].toString(),style: GoogleFonts.poppins(fontSize: 15,color: Colors.white),),)),

                  ),),
                );
              }),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: FutureBuilder<MyModel02>(
                future: newsViewModel.categoriesChannelApi(categoryname),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child:  SpinKitCircle(size: 50, color: Colors.blue),
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt!.toString());
                          return Padding(
                           padding: EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    height: height*.18,
                                    width: width*.3,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      child: spinKit,
                                    ),
                                    errorWidget: (context, url, error) => const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Container(

                                    height: height*.18,
                                    child: Padding(
                                      padding: EdgeInsets.only(left:15),
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(snapshot.data!.articles![index].title.toString(),
                                            style: GoogleFonts.poppins(color:Colors.red,fontSize: 15,fontWeight: FontWeight.w700),maxLines: 3,),
                                          Spacer(),
                                          Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(snapshot .data!.articles![index].source!.name.toString(),style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w700)),
                                              Text(format.format(dateTime),style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 10),maxLines: 3,),

                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
const spinKit = SpinKitCircle(
  size: 50,
  color: Colors.amber,
);
