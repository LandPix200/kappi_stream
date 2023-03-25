// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

import 'package:getwidget/getwidget.dart';
import 'package:kappi_stream/logic/api.dart';
import 'package:youtube_api/youtube_api.dart';

import '../logic/nav.dart';
import 'l_video.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key, this.sc = "IUC Cameroun"});

  String sc;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        searchBar: true,
        searchHintText: widget.sc,
        title: Text("Kappi stream"),
        onSubmitted: (s) {
          setState(() {
            widget.sc = s;
          });
        },
      ),
      body: Center(
          child: FutureBuilder(
        future: callApi("${widget.sc} en français"),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return SingleChildScrollView(
              child: Column(
                children: snapshot.data!.map((e) => VideoViewer(e: e)).toList(),
              ),
            );
          }

          if (snapshot.hasError) {
            return Text(
              "Problème de connexion",
              style: Theme.of(context).textTheme.displayLarge,
            );
          }

          return CircularProgressIndicator();
        },
      )),
    );
  }
}

class VideoViewer extends StatefulWidget {
  const VideoViewer({
    Key? key,
    required this.e,
  }) : super(key: key);

  final YouTubeVideo e;

  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  bool fav = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: GFCard(
        image: Image.network(widget.e.thumbnail.medium.url!),
        showImage: true,
        title: GFListTile(
          titleText: widget.e.title,
          description: widget.e.description != null
              ? Text("\n${widget.e.description!}")
              : null,
          subTitleText: widget.e.duration,
        ),
        buttonBar: GFButtonBar(
            alignment: WrapAlignment.spaceBetween,
            runAlignment: WrapAlignment.spaceBetween,
            spacing: 100,
            children: [
              GFButton(
                color: Colors.deepOrange,
                size: 40,
                onPressed: () {
                  push(LVideoPage(video: widget.e), context);
                },
                text: "LIRE LA VIDEO",
              ),
              GFIconButton(
                  color: Colors.black,
                  type: GFButtonType.transparent,
                  icon: Icon(
                    fav ? Icons.favorite : Icons.favorite_border,
                    color: Colors.deepOrange,
                  ),
                  onPressed: () {
                    setState(() {
                      fav = !fav;
                      if (fav) {
                        GFToast.showToast("Vidéo ajoutée aux favories", context,
                            backgroundColor: Colors.deepOrange);
                      }
                    });
                  })
            ]),
      ),
    );
  }
}
