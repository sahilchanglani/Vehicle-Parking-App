import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vehicle_management/home/settings_form.dart';
import 'package:vehicle_management/models/user.dart';
import 'package:vehicle_management/services/auth.dart';
import 'package:vehicle_management/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:latlong/latlong.dart" as latLng;
import 'package:vehicle_management/services/ticket_confirmation.dart';


class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  int endTime = null;
  int bookingID = null;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);


    Widget _bookTicket(int id){
      return Container(
        child: IconButton(
          icon: Icon(FontAwesomeIcons.mapMarkerAlt),
          tooltip: 'Book Ticket',
          onPressed: (){
            showModalBottomSheet(
                context: context,
                builder: (builder){
                  endTime = endTime==null ? DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60: endTime;
                  Widget confirmation = bookingID==null||bookingID==id?TicketConfirmation().getConfirmation(endTime,id): TicketConfirmation().confirmationDenied();
                  bookingID= bookingID==null?id:bookingID;
                  return confirmation;
                }
            );
          },
        ),
      );
    }

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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.grey[700],
                      Colors.grey[300]
                    ]
                  )
                ),
                accountName: Text('${userData.name}',style: TextStyle(color: Colors.black),),
                accountEmail: Text(""),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                  child: Text(
                    "${userData.name[0]}",
                    style: TextStyle(fontSize: 40.0, color: Colors.black),

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
        body: fm.FlutterMap(
          options: fm.MapOptions(
            center: latLng.LatLng(34.056340, -118.232050),
            zoom: 13
          ),
          layers: [
            fm.TileLayerOptions(
              urlTemplate: "https://api.mapbox.com/styles/v1/sahilkc/cknnjtdzz4gry17mgx37nmq8t/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2FoaWxrYyIsImEiOiJja25uaXA2NWUwN25vMm5udjM5Mml3cDEzIn0.xblxTAkRzXOQcwUfccVjnQ",
              additionalOptions: {
                'accessToken': "pk.eyJ1Ijoic2FoaWxrYyIsImEiOiJja25uajQxdGsxNHNlMnFueDZrOGYzY3M2In0.c0LfAAqTNTIbdIOPlUiEuQ",
                'id': 'sahil.sahil'
              }
            ),
            fm.MarkerLayerOptions(
              markers: [
                fm.Marker(
                  height: 80,
                  width: 80,
                  point: latLng.LatLng(34.056340, -118.232050),
                  builder: (ctx)=> _bookTicket(1),
                ),
                fm.Marker(
                  height: 80,
                  width: 80,
                  point: latLng.LatLng(34.06296107872455, -118.23954122733261),
                  builder: (ctx)=> _bookTicket(2),
                ),
                fm.Marker(
                  height: 80,
                  width: 80,
                  point: latLng.LatLng(34.02361170670473, -118.23055569793258),
                  builder: (ctx)=> _bookTicket(3),
                ),
                fm.Marker(
                  height: 80,
                  width: 80,
                  point: latLng.LatLng(34.05464448981627, -118.26070282099853),
                  builder: (ctx)=> _bookTicket(4),
                ),
                fm.Marker(
                  height: 80,
                  width: 80,
                  point: latLng.LatLng(34.04488135924512, -118.20944900689301),
                  builder: (ctx)=> _bookTicket(5),
                ),
                fm.Marker(
                  height: 80,
                  width: 80,
                  point: latLng.LatLng(34.09488135924512, -118.22941106979265),
                  builder: (ctx)=> _bookTicket(6),
                ),
                fm.Marker(
                  height: 80,
                  width: 80,
                  point: latLng.LatLng(34.01488135924512, -118.2601954883924),
                  builder: (ctx)=> _bookTicket(7),
                ),
                fm.Marker(
                  height: 80,
                  width: 80,
                  point: latLng.LatLng(34.10508517248872, -118.23994881911624),
                  builder: (ctx)=> _bookTicket(8),
                ),
                fm.Marker(
                  height: 80,
                  width: 80,
                  point: latLng.LatLng(34.08032665612467, -118.20091419023335),
                  builder: (ctx)=> _bookTicket(9),
                ),

              ]
            )
          ],
        ),
      );
    }
    );
  }
}
