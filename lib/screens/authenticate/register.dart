import 'package:vehicle_management/services/auth.dart';
import 'package:vehicle_management/shared/constants.dart';
import 'package:vehicle_management/shared/loading.dart';
import 'package:flutter/material.dart';


class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[700],
          elevation: 0,
          title: Text('Sign up to Par-King'),
          actions: [
            FlatButton.icon(
                onPressed: () {
                  widget.toggleView();
                },
                icon: Icon(Icons.person,color: Colors.limeAccent,),
                label: Text('Log in',style: TextStyle(color: Colors.limeAccent),))
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText :'Email'),
                  validator: (val) => val.isEmpty ? "Enter an email" : null,
                  onChanged: (val) {
                    email = val;
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText :'Password'),
                  validator: (val) => val.length < 6? "Enter password with 6+ characters" : null,
                  obscureText: true,
                  onChanged: (val) {
                    password = val;
                  },
                ),
                SizedBox(height: 20,),
                RaisedButton(
                    color: Colors.black,
                    child: Text('Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.registerWithEmail(email: email, password: password);
                        if(result == null){
                          setState(() {
                            error = 'Please enter a valid email';
                            loading = false;
                          });
                        }
                      }
                    }),
                SizedBox(height: 12,),
                Text(error,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize : 12
                  ),
                )

              ],
            ),
          ),
        )
    );
  }
}
