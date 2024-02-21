import 'package:flutter/material.dart';
import 'package:flutter_api/app/app.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 44, 44, 44),
        ),
        home: HomePage(),
      ),
    );
