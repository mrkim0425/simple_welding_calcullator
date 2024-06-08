import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:simple_welding_calcullator/home.dart';

final isDark = ValueNotifier(true);

void changeTheme() {
  isDark.value = !isDark.value;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (light, dark) {
      return ValueListenableBuilder(
          valueListenable: isDark,
          builder: (context, value, _) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              themeMode: value ? ThemeMode.dark : ThemeMode.light,
              darkTheme: ThemeData(colorScheme: dark),
              theme: ThemeData(colorScheme: light),
              home: const HomePage(),
            );
          });
    });
  }
}
