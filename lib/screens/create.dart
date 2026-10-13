import 'package:crud_app/data/datasource.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController degreeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Student'),
        centerTitle: true,
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    child: const Icon(Icons.clear),
                    onTap: () => nameController.clear(),
                  ),
                  labelText: 'Name',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: idController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    child: const Icon(Icons.clear),
                    onTap: () => idController.clear(),
                  ),
                  labelText: 'Id',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: degreeController,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    child: const Icon(Icons.clear),
                    onTap: () => degreeController.clear(),
                  ),
                  labelText: 'Degree',
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // TODO 5: Create a Map<String, dynamic> containing the text from your controllers
                  Map<String, dynamic> studentInfo ={
                    'name': nameController.text.trim(),
                    'id': idController.text.trim(),
                    'degree': degreeController.text.trim(),
                  };

                  // TODO 6: Call Database().addStudent() passing your map and the ID string
                  await Database().addStudent(
                    studentInfo,
                    idController.text.trim(),
                  );

                  // TODO 7: If successful, clear all three controllers
                  nameController.clear();
                  idController.clear();
                  degreeController.clear();

                  // TODO 8: Show a success message using Fluttertoast.showToast()
                  Fluttertoast.showToast(
                    msg: 'Student added successfully',
                  );
                },
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}