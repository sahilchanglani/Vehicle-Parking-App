import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vehicle_management/home/settings_form.dart';
import 'package:vehicle_management/models/owner.dart';
import 'package:vehicle_management/models/user.dart';
import 'package:vehicle_management/services/auth.dart';
import 'package:vehicle_management/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:latlong/latlong.dart" as latLng;


class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  GoogleMapController _googleMapController;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    void _showSettings(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child: SettingsForm(),
        );
      });
    }

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {

      UserData userData = snapshot.data;
      return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Par-King'),
          backgroundColor: Colors.grey[700],
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(

                accountName: Text('${userData.name}'),
                accountEmail: Text(""),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text(
                    "${userData.name[0]}",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                title: Text('Edit Profile'),
                onTap: () {
                  _showSettings();
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () async {
                  await _auth.signOut();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(34.056340, -118.232050),
            zoom: 11
          ),
          onMapCreated: (controller) => _googleMapController=controller,
          // markers: {
          //   Marker(
          //     position: LatLng(34.056340, -118.232050),
          //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          //
          //   ),
          // },
        )
      );
    }
    );
  }
}
