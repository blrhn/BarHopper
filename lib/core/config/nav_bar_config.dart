import 'package:flutter/material.dart';

enum NavBarEnum {
  map(Icons.map),
  search(Icons.search),
  userData(Icons.local_cafe_sharp);

  final IconData icon;

  const NavBarEnum(this.icon);

  String get label {
    return switch (this) {
      NavBarEnum.map => "Map",
      NavBarEnum.search => "Find",
      NavBarEnum.userData => "My Beers",
    };
  }
}
