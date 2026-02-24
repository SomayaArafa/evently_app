import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../ui/model/event_dm.dart';
import '../ui/model/user_dm.dart';

Future<void> createUserInFirestore(UserDM user) async {
  var userCollection = FirebaseFirestore.instance.collection("users");
  // userCollection.add();
  var emptyDoc = userCollection.doc(
    user.id,
  ); // create or search for doc with id
  emptyDoc.set(user.toJson());

  ///JSON
}

Future<UserDM> getUserFromFirestore(String uid, User? firebaseUser) async {
  var userCollection = FirebaseFirestore.instance.collection("users");
  DocumentSnapshot snapshot = await userCollection.doc(uid).get();

  if (!snapshot.exists || snapshot.data() == null) {

    final newUser = UserDM(
      id: uid,
      name: firebaseUser?.displayName ?? '',
      email: firebaseUser?.email ?? '',
      address: '',
      phoneNumber: '',
      favoriteEvents: [],
    );

    await userCollection.doc(uid).set(newUser.toJson());
    return newUser;
  }

  Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
  return UserDM.fromJson(json);
}
//
// Future<UserDM> getUserFromFirestore(String uid) async {
//   var userCollection = FirebaseFirestore.instance.collection("users");
//   DocumentSnapshot snapshot = await userCollection.doc(uid).get();
//   Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
//   return UserDM.fromJson(json);
// }

createEventInFirestore(EventDM event) async {
  CollectionReference collection = FirebaseFirestore.instance.collection(
    "events",
  );

  ///Solution 1
  // var documentRef = await collection.add(eventDM.toJson());
  // documentRef.update({"id": documentRef.id});
  ///Solution 2
  var documentRef = collection.doc();
  event.id = documentRef.id;

  ///Create empty
  await documentRef.set(event.toJson());
}
Future<void> updateEventInFirestore(EventDM event) async {
  var collection =
  FirebaseFirestore.instance.collection("events");

  await collection.doc(event.id).update(
  event.toJson()
  );
}
Future<void> deleteEventFromFirestore(EventDM event) async {
  try {
    final collection = FirebaseFirestore.instance.collection("events");
    await collection.doc(event.id).delete();
    print("Event deleted successfully: ${event.id}");
  } catch (e) {
    print("Failed to delete event: $e");
    throw Exception("Failed to delete event");
  }
}
removeEventFromFavorite(String eventId, UserDM user) {
  CollectionReference userCollection =
  FirebaseFirestore.instance.collection(UserDM.collectionName);
  var docRef = userCollection.doc(user.id);
  user.favoriteEvents.remove(eventId);
  docRef.update({"favorites": user.favoriteEvents});
}

Stream<List<EventDM>> getEventsFromFirestore() {
  CollectionReference collection =
      FirebaseFirestore.instance.collection("events");
  // QuerySnapshot querySnapshot =  collection.get(); ///Get all events from collection
  // ///
  // return querySnapshot.docs.map((doc){
  //   var json = doc.data() as Map<String, dynamic>;
  //   return EventDM.fromJson(json);
  // }).toList();
  Stream<QuerySnapshot> stream = collection.snapshots();

  ///Get all events from collection
  return stream.map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      var json = doc.data() as Map<String, dynamic>;
      return EventDM.fromJson(json);
    }).toList();
  });
}

addEventToFavorite(String eventId, UserDM user) {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection(UserDM.collectionName);
  var docRef = userCollection.doc(user.id);
  List<String> favoriteEventIds = List.of(user.favoriteEvents);
  favoriteEventIds.add(eventId);
  user.favoriteEvents = favoriteEventIds;
  docRef.update({"favorites": favoriteEventIds});
}



// Stream <List<EventDM>>getFavoriteEventsForUser(String uid){ }
Future<List<EventDM>> getFavoriteEventsForUser(String uid) async {
  if (UserDM.currentUser!.favoriteEvents.isEmpty) return [];
  CollectionReference eventsCollection = FirebaseFirestore.instance.collection(
    "events",
  );
  QuerySnapshot querySnapshot = await eventsCollection
      .where("id", whereIn: UserDM.currentUser!.favoriteEvents)
      .get();
  return querySnapshot.docs.map((doc) {
    var json = doc.data() as Map<String, dynamic>;
    return EventDM.fromJson(json);
  }).toList();
}

// updateEvent
