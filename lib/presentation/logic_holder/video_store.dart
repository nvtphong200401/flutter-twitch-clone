import 'package:webview_flutter/webview_flutter.dart';

class VideoStore {
  WebViewController? controller;
  late String videoUrl =
      'https://player.twitch.tv/?muted=false&parent=frosty&autoplay=true&controls=false&preload=metadata';
  late bool _paused = false;
  late final javascriptChannels = {
    JavascriptChannel(
      name: 'Pause',
      onMessageReceived: (message) => _paused = true,
    ),
    JavascriptChannel(
      name: 'Play',
      onMessageReceived: (message) {
        _paused = false;
        controller?.runJavascript(
            'document.getElementsByTagName("video")[0].muted = false;');
      },
    ),
  };
  void handlePausePlay() {
    try {
      if (_paused) {
        controller?.runJavascript(
            'document.getElementsByTagName("video")[0].play();');
        controller?.runJavascript(
            'document.getElementsByTagName("video")[0].muted = false;');
      } else {
        controller?.runJavascript(
            'document.getElementsByTagName("video")[0].pause();');
      }

      _paused = !_paused;
    } catch (e) {
      print(e.toString());
    }
  }

  void initVideo() {
    try {
      controller?.runJavascript(
          'document.getElementsByTagName("video")[0].addEventListener("pause", () => Pause.postMessage("video paused"));');
      controller?.runJavascript(
          'document.getElementsByTagName("video")[0].addEventListener("play", () => Play.postMessage("video playing"));');
    } catch (e) {
      print(e.toString());
    }
  }
}
