import 'package:vehicle_management/models/owner.dart';
import 'package:vehicle_management/services/auth.dart';
import 'package:vehicle_management/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override

  final AuthService _auth = AuthService();

  Widget build(BuildContext context) {

    // void _showSettings(){
    //   showModalBottomSheet(context: context, builder: (context){
    //     return Container(
    //       padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
    //       child: SettingsForm(),
    //     );
    //   });
    // }

    return StreamProvider<List<Owner>>.value(
      value: DatabaseService().owners,
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: Text('Vehicle Parking'),
          backgroundColor: Colors.blue[400],
          elevation: 0,
          actions: [
            FlatButton.icon(
                  icon: Icon(Icons.person),
                label: Text('Logout'),
                onPressed: () async {
                  await _auth.signOut();
                }
            ),
            // FlatButton.icon(
            //   icon: Icon(Icons.settings),
            //   label: Text('Settings'),
            //   onPressed: () => _showSettings(),
            // )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/coffee_bg.png'),
                  fit: BoxFit.cover
              ),

            ),
            child: Text('Home content')
        ),
      ),
    );
  }
}
