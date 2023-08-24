import 'package:brew_crew/design/inputdecorated.dart';
import 'package:brew_crew/design/loading.dart';
import 'package:brew_crew/model/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class bottomPanel extends StatefulWidget {
  const bottomPanel({super.key});

  @override
  State<bottomPanel> createState() => _bottomPanelState();
}

class _bottomPanelState extends State<bottomPanel> {
  final _key = GlobalKey<FormState>();
  List lev_sugar = ['0', '1', '2', '3', '4', '5'];
  String? _currname;
  String? _currsugar;
  int? _currstrength;

  @override
  Widget build(BuildContext context) {
    final currUser = Provider.of<custUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: currUser.uid).Userdata,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            UserData? data = snapshot.data;
            return Form(
                key: _key,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 00),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        "Update Your Coffee Brow!!",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          initialValue: data?.name,
                          decoration: inputdecorator.copyWith(
                            hintText: 'Name',
                          ),
                          validator: ((value) =>
                              value!.isEmpty ? 'Please Enter name!' : null),
                          onChanged: (val) => setState(() {
                            _currname = val;
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: DropdownButtonFormField(
                          value: _currsugar ?? data?.sugar,
                          items: lev_sugar.map((e) {
                            return DropdownMenuItem(
                                value: e, child: Text('$e sugar'));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _currsugar = value as String;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Slider(
                        value: (_currstrength ?? data?.strength)!.toDouble(),
                        activeColor: Colors.yellow[_currstrength ?? 100],
                        inactiveColor: Colors.yellow[_currstrength ?? 100],
                        min: 100.0,
                        max: 900.0,
                        divisions: 8,
                        onChanged: (val) {
                          setState(() {
                            _currstrength = val.round();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            // print(_currname);
                            // print(_currstrength);
                            // print(_currsugar);

                            if (_key.currentState!.validate()) {
                              await DatabaseService(uid: currUser.uid)
                                  .updateUserData(
                                _currsugar ?? data!.sugar,
                                _currname ?? data!.name,
                                _currstrength ?? data!.strength,
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Update'))
                    ],
                  ),
                ));
          }
        });
  }
}
