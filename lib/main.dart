import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_models/item_view_model.dart';
import 'views/item_tracker_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemViewModel()),
      ],
      child: MaterialApp(
        title: 'Item Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          iconTheme: IconThemeData(color: kDefaultIconDarkColor),
        ),
        home: ItemTrackerScreen(),
      ),
    );
  }
}
