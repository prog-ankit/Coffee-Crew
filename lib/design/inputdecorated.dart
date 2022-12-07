import 'package:flutter/material.dart';

final inputdecorator = InputDecoration(
    labelStyle: TextStyle(fontWeight: FontWeight.bold),
    fillColor: Colors.white,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue.shade300),
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ));
