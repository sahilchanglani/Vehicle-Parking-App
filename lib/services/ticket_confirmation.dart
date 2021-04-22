import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketConfirmation {

  Widget getConfirmation(int endTime,int id){

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
      child: Column(
        children: [
          Text('Ticket Booked', style: TextStyle(fontSize: 35.0, color: Colors.black),),
          SizedBox(height: 45,),
          QrImage(
            data: "Booking Confirmation: ID $id",
            version: QrVersions.auto,
            size: 200.0,
          ),
          SizedBox(height: 45,),
          CountdownTimer(
            endTime: endTime,
            widgetBuilder: (_, CurrentRemainingTime time) {
              if (time == null) {
                return Text('Booking cancelled');
              }
              return Text(
                '${time.hours??'0'} Hr, ${time.min??'0'} Mins, ${time.sec??'0'} Sec',
                style: TextStyle(fontSize: 30),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget confirmationDenied(){

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 12),
      child: Column(
        children: [
          Text('Booking Unsuccessful!', style: TextStyle(fontSize: 35.0, color: Colors.black),),
          SizedBox(height: 50,),
          Text('Other parking spot is already booked', style: TextStyle(fontSize: 22.0, color: Colors.black),),
          SizedBox(height: 100,),
          Text('Please try again later.', style: TextStyle(fontSize: 15.0, color: Colors.red),),
        ],
      ),
    );
  }

}
