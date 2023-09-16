import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/newsChannelHeadlineModel.dart';
import 'package:news_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum FilterList {bbcNews,aryNews,independent,cnn,alJazera}

class _HomeScreenState extends State<HomeScreen> {
  String name ="bbc_news";
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedMenu;
  @override

  Widget build(BuildContext context) {
    final format = DateFormat('MMM dd,yyyy');
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            'images/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        title: Text(
          "News",
          style: GoogleFonts.poppins(color:Colors.black,fontSize: 24, fontWeight: FontWeight.w700),
        ),
        actions: [


          PopupMenuButton<FilterList>(
              initialValue: selectedMenu,
              icon: Icon(Icons.more_vert,color: Colors.black,),
            onSelected: (FilterList item){
                //String updateName;
              if(FilterList.bbcNews.name==item.name){
                name="bbc-news";
              }
              if(FilterList.aryNews.name==item.name){
                name="ary-news";
              }
              if(FilterList.alJazera==item.name){
                name="al-jazeera-english";
              }
              if(FilterList.cnn.name==item.name){
                name="bbc-sport";
              }
              if(FilterList.independent.name==item.name){
                name='ansa';
              }
              setState(() {
                selectedMenu=item;
              });
            },
              itemBuilder:(context)=><PopupMenuEntry<FilterList>>[
                PopupMenuItem<FilterList>(
                  value: FilterList.bbcNews,
                    child: Text("BBC NEWS")),
                PopupMenuItem<FilterList>(
                    value: FilterList.aryNews,
                    child: Text("ARY NEWS")),
                PopupMenuItem<FilterList>(
                    value: FilterList.independent,
                    child: Text("Ansa NEWS")),
                PopupMenuItem<FilterList>(
                    value: FilterList.alJazera,
                    child: Text("Al Jazeera NEWS")),
                PopupMenuItem<FilterList>(
                    value: FilterList.cnn,
                    child: Text("BBC Sports")),
              ]),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<MyModel01>(
              future: newsViewModel.newsChannelApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child:  SpinKitCircle(size: 50, color: Colors.blue),
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt!.toString());
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: height * 0.6,
                              width: width * .9,
                              padding: EdgeInsets.symmetric(
                                horizontal: height * .02,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
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
                            ),
                            Positioned(
                              bottom: 20,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  alignment: Alignment.bottomCenter,
                                  height: height * .22,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.7,
                                        child: Text(
                                          snapshot
                                              .data!.articles![index].title
                                              .toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            snapshot
                                                .data!.articles![index].source!.name
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                  color: Colors.blue,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(width: width*.1,),
                                          Text(
                                            format.format(dateTime),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

const spinKit = SpinKitCircle(
  size: 50,
  color: Colors.amber,
);
