import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customLoading(){
  return Center(
    child: Container(
      color: Colors.transparent,
      child: const CircularProgressIndicator(),
      height: 50, width: 50,
    ),
  );
}