import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:vehicle_management/models/user.dart';
import 'package:vehicle_management/services/database.dart';
import 'package:vehicle_management/shared/constants.dart';
import 'package:vehicle_management/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentVehicleNo;
  int _currentVehicleType;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your profile',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20,),
                  // DropdownButtonFormField(
                  //   value: _currentVehicleType ?? userData.vehicleType,
                  //   items: vehicleTypes.map((vehicleType) =>
                  //       DropdownMenuItem(
                  //         value: vehicleType,
                  //         child: Text('$vehicleType Wheeler'),
                  //       )).toList(),
                  //   onChanged: (val) => setState(() => _currentVehicleType = val),
                  // ),
                  CustomRadioButton(
                    // buttonColor: Theme.of(context).canvasColor,
                    buttonLables: [
                      "2 wheeler",
                      "4 wheeler",
                    ],
                    buttonValues: [
                      2,
                      4,
                    ],
                    radioButtonValue: (val) =>  setState(() => _currentVehicleType = val),
                    defaultSelected: userData.vehicleType,
                    selectedColor: Theme.of(context).accentColor,
                    unSelectedColor: Colors.white,
                    padding: 5,
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    initialValue: userData.vehicleNo,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty? 'Please enter vehicle number' : null,
                    onChanged: (val) => setState(() => _currentVehicleNo = val),
                  ),
                  RaisedButton(
                    color: Colors.black,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name,
                            _currentVehicleNo ?? userData.vehicleNo,
                            _currentVehicleType ?? userData.vehicleType
                        );
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          }
          else{
            return Loading();
          }
        }
    );
  }
}
