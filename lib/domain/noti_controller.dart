
import 'dart:async';

class NotiController {
  final StreamController _streamController = StreamController();

  Stream getStream(){
    Stream stream = _streamController.stream.asBroadcastStream();
    return stream;
  }

  void addStream(dynamic data){
    print('data $data');
    _streamController.sink.add(data);
  }

}