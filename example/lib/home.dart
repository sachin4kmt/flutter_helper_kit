import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /*  MyCustomTextField(
              hintText: 'Hello Enter',
              // labelText: 'Hello Enter',
              // label: const GoogleLogoWidget(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              floatingLabelAlignment: FloatingLabelAlignment.center,
              prefixText: 'asd',
              suffixText: 'asd',
              keyboardAppearance: Brightness.light,

              // cursorColor: Colors.red,

              onFieldSubmitted: (value) {
                // print(value);
              },
              onSaved: (newValue) {
                print(newValue);
              },
              textAlignVertical: TextAlignVertical.bottom,
              borderSide: const BorderSide(width: 1, color: Colors.black),
              // errorBorderColor: Colors.green,
              isCollapsed: true,
              isDense: true,
              errorStyle: const TextStyle(color: Colors.red),
              controller: controller,
              validator: (value) {
                if (value.isEmptyOrNull) {
                  return 'please enter value';
                }
                return null;
              },
            ),
           */
            20.height(),
            AppButton(
              onTap: () {
                if (!(formKey.currentState?.validate() ?? false)) {
                  print('Not Validate = ${formKey.currentState?.validate()}');
                  return;
                }
                formKey.currentState?.save();
                print('Validate => ${formKey.currentState?.validate()}');
              },
              text: 'Submit',
            )
          ],
        ),
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
