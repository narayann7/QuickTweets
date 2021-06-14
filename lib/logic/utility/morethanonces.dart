import 'package:flutter/material.dart';

void teleport(BuildContext context, String screen) {
  Navigator.of(context).pushNamed(screen);
}
