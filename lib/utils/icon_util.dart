import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'book': Icons.book,
  'accessibility': Icons.accessibility,
  'library_music': Icons.library_music,
};

Icon getIcon(String nombreIcono) {
  return Icon(
    _icons[nombreIcono],
    color: Colors.blue,
  );
}
