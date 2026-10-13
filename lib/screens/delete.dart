import 'package:crud_app/data/datasource.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({super.key});

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  TextEditingController idController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delete'), centerTitle: true),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    // TODO: Implement the UI for the Delete Screen
    // 1. Return a SafeArea with Padding.
    // 2. Add a TextField hooked up to the `idController`.
    // 3. Add an ElevatedButton to trigger the deletion.
    // Hint: Call Database().deleteStudent(idController.text) inside onPressed
    //       and use Fluttertoast to show a success message.

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Student ID',
                hintText: 'Enter the student ID to delete',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete Student'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  final String id = idController.text.trim();

                  if (id.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please enter a student ID');
                    return;
                  }

                  try {
                    await Database().deleteStudent(id);

                    if (!mounted) return;

                    idController.clear();

                    Fluttertoast.showToast(msg: 'Student deleted successfully');
                  } catch (e) {
                    Fluttertoast.showToast(msg: 'Failed to delete student');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
