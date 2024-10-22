import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemViewModel extends ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => _items;

  void addItem(String name, String description) {
    _items.add(Item(name: name, description: description));
    notifyListeners();
  }

  void editItem(int index, String name, String description) {
    _items[index] = Item(name: name, description: description);
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
