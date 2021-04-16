import 'package:vehicle_management/models/user.dart';
import 'package:vehicle_management/models/owner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference ownerCollection = Firestore.instance.collection('Owners');

  Future updateUserData(String sugars, String name, int strength) async{
    return await ownerCollection.document(uid).setData({
      'sugars':sugars,
      'name':name,
      'strength':strength,
    });
  }
  //List of brew from snapshot
  List<Owner> _ownerListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Owner(
          name: doc.data['name'] ?? '',
          vehicleNo: doc.data['vehicleNo'] ?? '',
          vehicleType: doc.data['vehicleType'] ?? 2
      );
    }).toList();
  }
  // get brews stream
  Stream<List<Owner>> get owners {
    return ownerCollection.snapshots().map(_ownerListFromSnapshot);
  }
  // UserData from Doc snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        vehicleNo: snapshot.data['vehicleNo'],
        vehicleType: snapshot.data['vehicleType']
    );
  }
  // GET User doc stream
  Stream<UserData> get userData {
    return ownerCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

}