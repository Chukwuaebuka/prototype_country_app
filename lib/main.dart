import 'package:country_app_prototype/screens/home_screen.dart';
import 'package:country_app_prototype/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const CountryApp(),
    ),
  );
}

class CountryApp extends StatelessWidget {
  const CountryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
        title: 'Country App',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeProvider.themeMode,
        home: const HomeScreen(),
      );
    });
  }
}
