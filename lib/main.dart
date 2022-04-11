import 'package:clipboarda/app/app.locator.dart';
import 'package:clipboarda/app/app.router.dart';
import 'package:fluent_ui/fluent_ui.dart' as fui;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://yrjegftvatzknegxuqeo.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlyamVnZnR2YXR6a25lZ3h1cWVvIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDc0MTQ3NTksImV4cCI6MTk2Mjk5MDc1OX0.clTdkEMU71IFBcAA-M5GQ4PqEoY4ciJlNqA_7hB-dzU',
    debug: true,
  );
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RootPage();
  }
}

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return fui.FluentApp(
      themeMode: ThemeMode.dark,
      theme: fui.ThemeData(brightness: Brightness.dark),
      navigatorKey: StackedService.navigatorKey,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [StackedService.routeObserver],
      title: 'Clyppi',
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}

