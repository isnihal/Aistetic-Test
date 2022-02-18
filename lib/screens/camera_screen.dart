import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:universal_io/io.dart' as io;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  static final html.VideoElement _webcamVideoElement = html.VideoElement();

  @override
  void initState() {
    super.initState();

    // Register a webcam
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('webcamVideoElement',
            (int viewId) {
          getMedia();
          return _webcamVideoElement;
        });
  }

  getMedia() {
    html.window.navigator.mediaDevices
        ?.getUserMedia({"video": true}).then((streamHandle) {
      _webcamVideoElement
        ..srcObject = streamHandle
        ..autoplay = true;
    }).catchError((onError) {
      throw(onError);
    });
  }

  switchCameraOff() {
    if (_webcamVideoElement.srcObject != null &&
        _webcamVideoElement.srcObject!.active!) {
      var tracks = _webcamVideoElement.srcObject?.getTracks();

      //stopping tracks and setting srcObject to null to switch camera off
      _webcamVideoElement.srcObject = null;

      tracks?.forEach((track) {
        track.stop();
      });
    }
  }

  @override
  void dispose() {
    switchCameraOff();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: mediaQuery.size.width * 0.75,
                height: mediaQuery.size.height * 0.75,
                child: HtmlElementView(
                  key: UniqueKey(),
                  viewType: 'webcamVideoElement',
                )),
            const SizedBox(height: 24,),
            Text("Operating System: "+io.Platform.operatingSystem,style: Theme.of(context).textTheme.headline6,)
          ],
        ),
      ),
    );
  }
}