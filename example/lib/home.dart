import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: SizedBox(
          height: 500,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
            const Text('data'),
            Expanded(
              child: Container(color: context.primaryColor,child: const Row(
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
            ElevatedButton(onPressed: () {}, child: const Text('hey'))
          ]),
        ),
      ),
    );
  }
}
