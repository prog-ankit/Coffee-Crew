import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../model/brew.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brewdata = Provider.of<List<brew>>(context);
    // try {
    // print(brewdata);
    // brewdata.forEach((element) {
    //   print(element.name);
    //   print(element.sugar);
    //   print(element.strength);
    // });
    // } catch (e) {
    //   print("Caught error $e");
    // }

    // print("List of data ==> ${brewdata!.docs}");

    //This is used when QuerySnapshot is type of Provider
    // if (brewdata!.docs != null) {
    //   for (var ele in brewdata.docs) {
    //     print("Hello ==> ${ele.data()}");
    //   }
    // } else {
    //   CircularProgressIndicator();
    // }
    return ListView.builder(
        itemCount: brewdata.length,
        itemBuilder: ((context, index) {
          int strength = brewdata[index].strength;
          return Padding(
            //Gave Outer Padding
            padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 5.0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Colors.yellow[strength],
                  ),
                  title: Text(brewdata[index].name),
                  subtitle: Text('Takes ${brewdata[index].sugar}'),
                ),
              ),
            ),
          );
        }));
  }
}
