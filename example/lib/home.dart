import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 500,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('data'),
                Expanded(
                  child: Container(
                      color: context.primaryColor,
                      child: const Row(
                        children: [
                          Text('data'),
                          // Spacer(),
                          // const MaxSpace(120),
                          Space.expand(20),
                          Text('data'),
                        ],
                      )),
                ),
                // const MaxSpace(120),
                // SizedBox(height: 120),
                ElevatedButton(
                    onPressed: () {

                      showDialogWithCloseIcon(
                        context: context,
                        title: const Icon(Icons.image, size: 40),
                        content: Column(children: [
                          const Text('Upload your profile Picture.'),
                          20.height,
                          OutlinedButton(
                              onPressed: () {}, child: const Text('Upload'))
                        ]),
                        closeButtonPosition: FlutterTagPosition.topEnd(),
                        closeButtonAnimation: const FlutterTagAnimation.slide(),
                        closeButtonStyle: FlutterTagStyle(
                            borderRadius: 1000.circularSharpBorderRadius,
                            shape: FlutterTagShape.circle),
                        shape: SharpRectangleBorder(
                            borderRadius: 16.circularSharpBorderRadius),
                        closeIcon: const Icon(Icons.clear, color: Colors.white),
                        dialogColor: Colors.white,
                      );
                    },
                    child: const Text('hey')),
              ]),
        ),
      ),
    );
  }
}
