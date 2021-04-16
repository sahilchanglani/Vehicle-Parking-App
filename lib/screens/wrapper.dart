import 'package:vehicle_management/screens/authenticate/authenticate.dart';
import 'package:vehicle_management/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_management/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // Return either home or authenticate widget
    return user==null? Authenticate():Home();
  }
}
