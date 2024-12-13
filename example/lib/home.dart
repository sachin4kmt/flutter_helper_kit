import 'package:example/pagination_list_view_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppButton(
            text: 'List View Pagination Example',
            color: Colors.red,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PaginationListViewExample()));
            },
          ),
          AppButton(
            text: 'DialogForm Example',
            // color: Colors.red,
            onTap: () {},
          ),
          4.height(),
        ],
      ),
    );
  }
}

class TestModel {
  int? id;
  String? name;

  TestModel({this.id, this.name});

  static List<TestModel> list = [
    TestModel(name: 'hello'),
    TestModel(id: 1, name: 'hello 1'),
    TestModel(id: 2),
    TestModel(id: 3, name: 'hello 3'),
    TestModel(id: 4, name: 'hello 4'),
  ];
}
