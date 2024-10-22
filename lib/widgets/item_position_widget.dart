import 'dart:developer';

import 'package:flutter/material.dart';

class ItemPositionWidget extends StatefulWidget {
  const ItemPositionWidget({super.key});

  @override
  _ItemPositionWidgetState createState() => _ItemPositionWidgetState();
}

class _ItemPositionWidgetState extends State<ItemPositionWidget> {
  RenderBox? _renderBox;
  Offset? _position;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _calculatePosition,
      child: Container(
        color: Colors.orange,
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'Tap to calculate position',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _calculatePosition() {
    setState(() {
      _renderBox = context.findRenderObject() as RenderBox;
      _position = _renderBox!.localToGlobal(Offset.zero);
    });
    log("Widget position: $_position");
  }
}
