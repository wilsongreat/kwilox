import 'package:brayon_news_network_app/app/models/news_model/NewsModel.dart';
import 'package:brayon_news_network_app/app/pages/create_news.dart';
import 'package:brayon_news_network_app/app/pages/edit_news.dart';
import 'package:brayon_news_network_app/app/services/services.dart';
import 'package:brayon_news_network_app/app/widgets/text_views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<NewsModel> incomingNews;
  @override
  void initState() {
    incomingNews = NewsServices().getAllNews();
    super.initState();

    ///whatever you want to run on page build
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final data = Provider.of<NewsServices>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 20.0, bottom: 10),
          child: RefreshIndicator(
            onRefresh: () => data.getAllNews(),
            child: Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.newspaper_rounded,
                            color: PURPLE,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TextView(
                            text: 'All News',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 30,
                            color: BLACK,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => showDialog(
                                context: context,
                                builder: (context) {
                                  return MaterialButton(
                                    onPressed: null,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 50),
                                      alignment: Alignment.topCenter,
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(
                                            offset: const Offset(12, 26),
                                            blurRadius: 50,
                                            spreadRadius: 0,
                                            color: Colors.grey.withOpacity(.1)),
                                      ]),
                                      child: TextField(
                                        controller:
                                            data.searchTextEditingController,
                                        onChanged: (value) {
                                          //Do something wi
                                          // setState(() {
                                          //   trxList = trxList
                                          //       .where((element) => element.name
                                          //           .contains(value))
                                          //       .toList();
                                          // });
                                        },
                                        decoration: const InputDecoration(
                                          // prefixIcon: const Icon(
                                          //   Icons.search,
                                          //   color: Color(0xff4338CA),
                                          // ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Search News',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 2.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                            child: Icon(
                              Icons.search,
                              color: BLACK,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.more_horiz,
                            color: BLACK,
                            size: 30,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // if (data.searchTextEditingController.text.isNotEmpty)
                  //   FutureBuilder<List<SearchModel>>(
                  //     future: NewsServices()
                  //         .newsSearch(data.searchTextEditingController.text),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState == ConnectionState.done) {
                  //         return Expanded(
                  //           child: ListView.builder(
                  //               itemCount: snapshot.data!.length,
                  //               itemBuilder: (context, i) {
                  //                 var newsData = snapshot.data![i];
                  //                 return Container(
                  //                   height: 100,
                  //                   decoration: BoxDecoration(
                  //                       boxShadow: [
                  //                         BoxShadow(
                  //                             color: BLACK.withOpacity(.06),
                  //                             spreadRadius: 3,
                  //                             blurRadius: 4)
                  //                       ],
                  //                       color: WHITE,
                  //                       borderRadius:
                  //                           BorderRadius.circular(10.0)),
                  //                   padding: EdgeInsets.all(10.0),
                  //                   child: Row(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       ClipRRect(
                  //                         borderRadius:
                  //                             BorderRadius.circular(6),
                  //                         child: Image.network(
                  //                           'https://yt3.ggpht.com/ytc/AMLnZu8i_0xzIMFM-Ngk9hW1OJzhneHzmYsQhlwF869TdoU=s900-c-k-c0x00ffffff-no-r',
                  //                           height: 80,
                  //                         ),
                  //                       ),
                  //                       SizedBox(
                  //                         width: 10.0,
                  //                       ),
                  //                       Expanded(
                  //                           child: Column(
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.start,
                  //                         children: [
                  //                           TextView(
                  //                             text: '${newsData.data!.title}',
                  //                             textOverflow:
                  //                                 TextOverflow.ellipsis,
                  //                             maxLines: 2,
                  //                             fontSize: 14,
                  //                             fontWeight: FontWeight.w500,
                  //                           ),
                  //                           SizedBox(
                  //                             height: 20,
                  //                           ),
                  //                           TextView(
                  //                             text:
                  //                                 '${newsData.data!.bodyOfNews}',
                  //                             textOverflow:
                  //                                 TextOverflow.ellipsis,
                  //                             maxLines: 2,
                  //                             fontSize: 12,
                  //                             fontWeight: FontWeight.w400,
                  //                           )
                  //                         ],
                  //                       )),
                  //                       Align(
                  //                         alignment: Alignment.bottomCenter,
                  //                         child: TextView(
                  //                           text: 'Read More',
                  //                           onTap: () {
                  //                             // Navigator.push(
                  //                             //     context,
                  //                             //     MaterialPageRoute(
                  //                             //         builder: (_) => EditNews(
                  //                             //               newsModel: snapshot
                  //                             //                   .data!.data![i],
                  //                             //             )));
                  //                           },
                  //                           color: Colors.blue,
                  //                           fontSize: 12,
                  //                           fontWeight: FontWeight.w400,
                  //                         ),
                  //                       )
                  //                     ],
                  //                   ),
                  //                 );
                  //               }),
                  //         );
                  //       } else {
                  //         return Center(
                  //           child: CircularProgressIndicator(
                  //               color: Colors.deepPurpleAccent),
                  //         );
                  //       }
                  //     },
                  //   ),

                  FutureBuilder<NewsModel>(
                      future: NewsServices().getAllNews(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.data!.length,
                                itemBuilder: (context, i) {
                                  var newsData = snapshot.data!.data![i];
                                  return Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: BLACK.withOpacity(.06),
                                              spreadRadius: 3,
                                              blurRadius: 4)
                                        ],
                                        color: WHITE,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.network(
                                            'https://yt3.ggpht.com/ytc/AMLnZu8i_0xzIMFM-Ngk9hW1OJzhneHzmYsQhlwF869TdoU=s900-c-k-c0x00ffffff-no-r',
                                            height: 80,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextView(
                                              text: '${newsData.title}',
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                              maxLines: 2,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextView(
                                              text: '${newsData.bodyOfNews}',
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                              maxLines: 2,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            )
                                          ],
                                        )),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: TextView(
                                            text: 'Read More',
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => EditNews(
                                                            newsModel: snapshot
                                                                .data!.data![i],
                                                          )));
                                            },
                                            color: Colors.blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                                color: Colors.deepPurpleAccent),
                          );
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CreateNews()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
