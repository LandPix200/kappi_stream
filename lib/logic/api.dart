import 'package:flutter/foundation.dart';
import 'package:youtube_api/youtube_api.dart';

const String apiKey = "AIzaSyAbwWKpNNDTCVyGwzuvfx4R8z4-SZ_ggVc";

YoutubeAPI yt = YoutubeAPI(apiKey);

Future<List<YouTubeVideo>?> callApi(String q) async {
  try {
    await yt.search(q, type: "video");
    return await yt.nextPage();
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return null;
  }
}
