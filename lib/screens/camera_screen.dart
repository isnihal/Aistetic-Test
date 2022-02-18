import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: mediaQuery.size.width * 0.5,
              height: mediaQuery.size.height * 0.6,
              color: Colors.red,
            ),
            const SizedBox(height: 24,),
            Text("Operating System: "+Platform.operatingSystem,style: Theme.of(context).textTheme.headline6,)
          ],
        ),
      ),
    );
  }
}

