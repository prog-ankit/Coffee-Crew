import 'package:brew_crew/model/brew.dart';
import 'package:brew_crew/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String? uid;
  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brew_crew');

  List<brew> _datafromFirestore(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return brew(
          name: doc.get('name') ?? '',
          strength: doc.get('strength') ?? 0,
          sugar: doc.get('sugars') ?? '0',
        );
      }).toList();
    } catch (e) {
      print("Could be here $e");
      return [];
      //Exception:
      // Bad state: field does not exist within the DocumentSnapshotPlatform
    }
  }

  Future updateUserData(String sugar, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugar,
      'name': name,
      'strength': strength,
    });
  }

  Stream<List<brew>> get brewData {
    //1st technqiue to get and send data to other file
    // List data = [];
    // try {
    //   await brewCollection.get().then((querySnapshot) {
    //     querySnapshot.docs.forEach((element) {
    //       data.add(element.data());
    //     });
    //   });
    // } catch (e) {
    //   print(e);
    // }
    // return data;
    //Return Type would be - Future<List>

    //2nd technqiue - Stream Builder
    // return brewCollection.snapshots();  function name - Future<Stream<QuerySnapshot>> brewData()

    //3nd technqiue - Stream Provider

    return brewCollection.snapshots().map((snap) => _datafromFirestore(snap));
  }

  UserData _userDataFirestore(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid.toString(),
        name: snapshot.get('name'),
        sugar: snapshot.get('sugars'),
        strength: snapshot.get('strength'));
  }

  Stream<UserData> get Userdata {
    return brewCollection
        .doc(uid)
        .snapshots()
        .map((event) => _userDataFirestore(event));
  }
}
