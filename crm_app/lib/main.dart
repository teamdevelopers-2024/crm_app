import 'package:flutter/material.dart';
import 'package:motta/dependency_injection.dart';
import 'package:motta/views/screens/home/dashboard_page.dart';

void main() {
  runApp(const CRMApp());
}

class CRMApp extends StatelessWidget {
  const CRMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlocProviders(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
