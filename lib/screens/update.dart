import 'package:crud_app/data/datasource.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateScreen extends StatefulWidget {
  final String name;
  final int id;
  final String degree;

  const UpdateScreen({
    super.key,
    required this.name,
    required this.id,
    required this.degree,
  });

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController degreeController = TextEditingController();

  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    // Pre-filling the controllers with the data passed from the StudentCard
    nameController.text = widget.name;
    idController.text = widget.id.toString();
    degreeController.text = widget.degree;
  }

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    degreeController.dispose();
    super.dispose();
  }

  Future<void> updateStudent() async {
    final String name = nameController.text.trim();
    final String idText = idController.text.trim();
    final String degree = degreeController.text.trim();

    if (name.isEmpty || idText.isEmpty || degree.isEmpty) {
      Fluttertoast.showToast(msg: 'Please complete all fields');
      return;
    }

    final int? studentId = int.tryParse(idText);

    if (studentId == null) {
      Fluttertoast.showToast(msg: 'Student ID must be a number');
      return;
    }

    final Map<String, dynamic> studentInfo = {
      'name': name,
      'id': studentId,
      'degree': degree,
    };

    try {
      setState(() {
        isUpdating = true;
      });

      await Database().updateStudentDetails(studentInfo, idText);

      if (!mounted) return;

      Fluttertoast.showToast(msg: 'Student updated successfully');

      Navigator.pop(context, true);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to update student');
    } finally {
      if (mounted) {
        setState(() {
          isUpdating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Student'), centerTitle: true),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    // TODO: Implement the Update Form UI
    // 1. Create TextFields for Name, ID, and Degree using their respective controllers.
    // 2. Add an ElevatedButton to submit the update.
    // Hint: Construct a Map<String, dynamic> with the updated values and pass it
    //       to Database().updateStudentDetails(studentDetails, idController.text).

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Student Name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: idController,
            readOnly: true,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Student ID',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.badge),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: degreeController,
            decoration: const InputDecoration(
              labelText: 'Degree',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.school),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isUpdating ? null : updateStudent,
              icon: isUpdating
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.update),
              label: Text(isUpdating ? 'Updating...' : 'Update Student'),
            ),
          ),
        ],
      ),
    );
  }
}
