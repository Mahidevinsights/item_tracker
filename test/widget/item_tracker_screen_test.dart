import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:item_tracker/view_models/item_view_model.dart';
import 'package:item_tracker/views/item_tracker_screen.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Add and display items', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ItemViewModel(),
        child: MaterialApp(home: ItemTrackerScreen()),
      ),
    );
    await tester.enterText(find.byType(TextField).first, 'New Item');
    await tester.enterText(find.byType(TextField).last, 'New Description');
    await tester.tap(find.text('Add Item'));
    await tester.pump();
    expect(find.text('New Item'), findsOneWidget);
  });
}
