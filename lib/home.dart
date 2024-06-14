import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppBar _appBar() =>
      AppBar(title: const Text('Theme Dependency Sample'), centerTitle: true);

  @override
  Widget build(BuildContext originalContext) {
    return Scaffold(
        appBar: _appBar(),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          ElevatedButton(
            onPressed: () => setState(() {}),
            child: const Text('setState()'),
          ),
          const SizedBox(height: 24),
          Expanded(
              child: ListView.builder(
            itemCount: 200,
            itemBuilder: (itemBuilderContext, index) {
              print("re-build: $index");
              // return Builder(builder: (context) {
              // if you use builderContext || originalContext,
              //   it'll be working make sense.
              return Text(
                "element: $index",
                textAlign: TextAlign.center,
                style: Theme.of(itemBuilderContext).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              );
              // });
            },
          )),
        ]));
  }
}
