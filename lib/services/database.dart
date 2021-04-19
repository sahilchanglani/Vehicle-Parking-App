import 'package:vehicle_management/models/user.dart';
import 'package:vehicle_management/models/owner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference ownerCollection = Firestore.instance.collection('Owners');

  Future updateUserData(String name, String vehicleNo, int vehicleType) async{
    return await ownerCollection.document(uid).setData({
      'name':name,
      'vehicleNo':vehicleNo,
      'vehicleType':vehicleType,
    });
  }
  // UserData from Doc snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        vehicleNo: snapshot.data['vehicleNo'],
        vehicleType: snapshot.data['vehicleType'],
    );
  }
  // GET User doc stream
  Stream<UserData> get userData {
    return ownerCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

}