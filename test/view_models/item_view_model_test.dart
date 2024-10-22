import 'package:flutter_test/flutter_test.dart';
import 'package:item_tracker/view_models/item_view_model.dart';

void main() {
  test('Add item to list', () {
    final viewModel = ItemViewModel();
    viewModel.addItem('Item 1', 'Description 1');
    expect(viewModel.items.length, 1);
    expect(viewModel.items[0].name, 'Item 1');
  });
}
