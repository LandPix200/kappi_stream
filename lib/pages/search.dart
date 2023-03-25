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

class VideoViewer extends StatelessWidget {
  const VideoViewer({
    Key? key,
    required this.e,
  }) : super(key: key);

  final YouTubeVideo e;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: GFCard(
        image: Image.network(e.thumbnail.medium.url!),
        showImage: true,
        title: GFListTile(
          titleText: e.title,
          description:
              e.description != null ? Text("\n${e.description!}") : null,
          subTitleText: e.duration,
        ),
        buttonBar: GFButtonBar(
            alignment: WrapAlignment.spaceBetween,
            runAlignment: WrapAlignment.spaceBetween,
            spacing: 100,
            children: [
              GFButton(
                onPressed: () {
                  push(LVideoPage(video: e), context);
                },
                text: "LIRE LA VIDEO",
              ),
              GFIconButton(
                  type: GFButtonType.transparent,
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {})
            ]),
      ),
    );
  }
}
