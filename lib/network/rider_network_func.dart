import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant/firestore_keys.dart';
import '../model/rider_model.dart';
import 'help/transformer.dart';



class RiderNetwork with Transformers {

  Future<void> createNewRider({@required String userKey, @required String userName, @required String userNickName, @required String userPhone, @required String userEmail}) async {
    final DocumentReference userRef = FirebaseFirestore.instance.collection(COLLECTION_HOME).doc(DOCUMENT_ADMIN).collection(COLLECTION_RIDERS).doc(userKey);

    DocumentSnapshot snapshot = await userRef.get();

    if(!snapshot.exists){
      return await userRef.set(RiderModel.getMapForCreateUser(userKey: userKey, userEmail: userEmail, userName: userName, userNickName: userNickName, userPhone: userPhone));
    }
  }

  Stream<RiderModel> getUserModelStream(String userKey){
    return FirebaseFirestore.instance.collection(COLLECTION_HOME).doc(DOCUMENT_ADMIN).collection(COLLECTION_RIDERS).doc(userKey).snapshots().transform(toRider);
  }

}

RiderNetwork riderNetwork = RiderNetwork();