import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/item_view_model.dart';

class ItemTrackerScreen extends StatelessWidget {
  final TextEditingController addNameController = TextEditingController();
  final TextEditingController addDescriptionController =
      TextEditingController();

  ItemTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Tracker',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        centerTitle: true,
        elevation: 2,
        backgroundColor: const Color.fromARGB(255, 225, 54, 244),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWeb = constraints.maxWidth > 600;

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.all(isWeb ? 32.0 : 16.0),
            child: Consumer<ItemViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  children: [
                    Expanded(
                      child: isWeb
                          ? _buildWebListView(viewModel)
                          : _buildMobileListView(viewModel),
                    ),
                    _buildInputFields(context, viewModel, isWeb),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileListView(ItemViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.items.length,
      itemBuilder: (context, index) {
        final item = viewModel.items[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text(item.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _editItem(context, viewModel, index),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.redAccent.withOpacity(0.6),
                ),
                onPressed: () => viewModel.removeItem(index),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWebListView(ItemViewModel viewModel) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: viewModel.items.length,
      itemBuilder: (context, index) {
        final item = viewModel.items[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text(item.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _editItem(context, viewModel, index),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.redAccent.withOpacity(0.7),
                ),
                onPressed: () => viewModel.removeItem(index),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInputFields(
      BuildContext context, ItemViewModel viewModel, bool isWeb) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: addNameController,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: const TextStyle(color: Colors.white),
              hintText: 'Enter item name',
              hintStyle: const TextStyle(color: Colors.white70),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white),
              ),
              filled: true,
              fillColor: Colors.black12,
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: addDescriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
              labelStyle: const TextStyle(color: Colors.white),
              hintText: 'Enter item description',
              hintStyle: const TextStyle(color: Colors.white70),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white),
              ),
              filled: true,
              fillColor: Colors.black12,
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: isWeb ? 200 : double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (addNameController.text.isNotEmpty &&
                    addDescriptionController.text.isNotEmpty) {
                  viewModel.addItem(
                      addNameController.text, addDescriptionController.text);
                  addNameController.clear();
                  addDescriptionController.clear();
                }
              },
              child: const Text('Add Item'),
            ),
          ),
        ],
      ),
    );
  }

  void _editItem(BuildContext context, ItemViewModel viewModel, int index) {
    final TextEditingController editNameController = TextEditingController();
    final TextEditingController editDescriptionController =
        TextEditingController();

    editNameController.text = viewModel.items[index].name;
    editDescriptionController.text = viewModel.items[index].description;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: editNameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: editDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                viewModel.editItem(index, editNameController.text,
                    editDescriptionController.text);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
