// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:kappi_stream/pages/l_video.dart';
import 'package:kappi_stream/pages/login.dart';
import 'package:kappi_stream/pages/search.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:icons_plus/icons_plus.dart';

import '../logic/api.dart';
import '../logic/nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String qq = "Les films action les plus populaires 2023";

  late Future<List<YouTubeVideo>?> vids;

  @override
  void initState() {
    vids = callApi(qq);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        title: Text("Kappi stream"),
        actions: [
          IconButton(
              onPressed: () {
                pushR(LoginPage(), context);
              },
              icon: Icon(
                Iconsax.logout,
                color: Colors.deepOrange,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "    LES PLUS POPULAIRES",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward))
                ],
              ),
              FutureBuilder(
                future: vids,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Wrap(
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.center,
                      spacing: 15,
                      runSpacing: 15,
                      children: snapshot.data!.map((e) {
                        String tt = e.title;
                        List<String> w = [
                          "Nouveau",
                          "Film",
                          "Action",
                          "Francais",
                          "2022",
                          "2021",
                          "2020",
                          "Complet",
                          "D&#39;",
                          "Meilleur"
                        ];
                        for (var element in w) {
                          tt = tt.replaceFirstMapped(element, (match) => "");
                          tt = tt.replaceFirstMapped(
                              "${element}s", (match) => "");
                          tt = tt.replaceFirstMapped(
                              element.toLowerCase(), (match) => "");
                        }

                        return InkWell(
                          onTap: () {
                            push(LVideoPage(video: e), context);
                          },
                          child: GFImageOverlay(
                            child: Text(
                              "${tt.substring(0, 25)}...",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    color: Colors.white,
                                    backgroundColor:
                                        Colors.black.withOpacity(0.8),
                                    fontSize: 16,
                                  ),
                            ),
                            boxFit: BoxFit.cover,
                            width: 150,
                            height: 200,
                            image: CachedNetworkImageProvider(
                              e.thumbnail.medium.url!,
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "    LES MOTS LES PLUS UTILISES",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward))
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      ["Chatgpt", "Programmation", "Chats", "python", "Crypto"]
                          .map(
                            (e) => InkWell(
                              onTap: () {
                                push(
                                    SearchPage(
                                      sc: e,
                                    ),
                                    context);
                              },
                              child: Container(
                                margin: EdgeInsets.all(15),
                                width: 150,
                                height: 70,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    colors: [
                                      Colors.orange,
                                      Colors.deepOrange,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "@$e",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// body: SingleChildScrollView(
//         child: Column(
//           children: [
//             FutureBuilder(
//               future: callApi(qq),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData && snapshot.data != null) {
//                   return Column(
//                     children: snapshot.data!
//                         .map((e) => VideoViewer(
//                               e: e,
//                             ))
//                         .toList(),
//                   );
//                 }
//                 if (snapshot.hasError) {}

//                 return Column(
//                   children: [1, 2, 3, 4, 5]
//                       .map((e) => GFShimmer(
//                           child: GFCard(
//                               title: GFListTile(),
//                               content: Column(
//                                 children: [
//                                   Container(
//                                     height: 200,
//                                     width: double.maxFinite,
//                                     color: Colors.red,
//                                   ),
//                                   Container(
//                                     height: 100,
//                                     width: double.maxFinite,
//                                     color: Colors.red,
//                                   ),
//                                 ],
//                               ))))
//                       .toList(),
//                 );
//               },
//             )
//           ],
//         ),
//       ),


