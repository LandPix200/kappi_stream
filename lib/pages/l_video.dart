// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:kappi_stream/logic/api.dart';
import 'package:kappi_stream/logic/nav.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LVideoPage extends StatefulWidget {
  const LVideoPage({super.key, required this.video});

  final YouTubeVideo? video;

  @override
  State<LVideoPage> createState() => _LVideoPageState();
}

class _LVideoPageState extends State<LVideoPage> {
  YoutubePlayerController controller =
      YoutubePlayerController(initialVideoId: 'iLnmTe5Q2Qw');

  late Future<List<YouTubeVideo>?> toto;

  @override
  void initState() {
    toto = callApi("${widget.video!.title} en français");
    controller = YoutubePlayerController(initialVideoId: widget.video!.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(controller: controller),
        builder: (context, player) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.video!.title),
            ),
            body: SingleChildScrollView(
              child: GFStickyHeader(
                stickyContent: Column(
                  children: [
                    player,
                    GFCard(
                      title: GFListTile(
                        padding: EdgeInsets.all(0),
                        titleText: widget.video!.title,
                        icon: Icon(
                          Icons.download,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                content: FutureBuilder(
                  future: toto,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return SingleChildScrollView(
                        child: Column(
                          children: snapshot.data!
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GFListTile(
                                      onTap: () {
                                        push(
                                            LVideoPage(
                                                video: widget.video!
                                                  ..id = e.id),
                                            context);
                                      },
                                      avatar: CachedNetworkImage(
                                        imageUrl: e.thumbnail.small.url!,
                                        width: 100,
                                      ),
                                      titleText: e.title,
                                      subTitleText: e.duration!,
                                      color: Colors.white,
                                    ),
                                  ))
                              .toList(),
                        ),
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
              ),
            ),
          );
        });
  }
}
