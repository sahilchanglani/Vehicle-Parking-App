import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_management/models/user.dart';
import 'package:vehicle_management/screens/wrapper.dart';
import 'package:vehicle_management/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}