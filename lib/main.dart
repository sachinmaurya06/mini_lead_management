import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/lead_provider.dart';
import 'screens/lead_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LeadProvider()..loadLeads(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Lead Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LeadListScreen(),
    );
  }
}
