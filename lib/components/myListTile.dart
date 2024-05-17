import 'package:flutter/material.dart';
import 'package:gharbhada/consts/constants.dart';


ListTile MyListTile({String icon=profile_png, required String title, required  String subtitle}){
  return ListTile(
    leading: Image(image: AssetImage(icon),), 
    title: Text(title),
    subtitle: Text(subtitle),

    ); 
}