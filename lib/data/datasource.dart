import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/models/student.dart';

class Database {
  // TODO 1: Implement the CREATE operation
  Future<void> addStudent(Map<String, dynamic> studentInfo, String id) async {
    try {
      // 1. Access FirebaseFirestore.instance
      await FirebaseFirestore.instance
          // 2. Go to the "Students" collection
          .collection('Students')
          // 3. Target the specific document using the provided 'id'
          .doc(id)
          // 4. Use .set() to save the 'studentInfo' map
          .set(studentInfo);
    } catch (e) {
      print('Error adding student: $e');
    }
  }

  // TODO 2: Implement the READ operation
  Future<List<Student>> getStudentDetails() async {
    List<Student> studentDetailsList = [];
    try {
      // 1. Fetch the QuerySnapshot from the "Students" collection using .get()
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('Students').get();

      // 2. Loop through the querySnapshot.docs
      for (var document in querySnapshot.docs) {
        Map<String, dynamic> data = document.data();
        // 3. Extract 'name', 'id', and 'degree' to instantiate Student objects
        Student student = Student(
          name: data['name'].toString(),
          id: int.parse(data['id'].toString()),
          degree: data['degree'].toString(),
        );

        // 4. Add each Student to 'studentDetailsList'
        studentDetailsList.add(student);
      }

      return studentDetailsList;
    } catch (e) {
      print('Error fetching students: $e');
      return [];
    }
  }

  // TODO 3: Implement the UPDATE operation
  Future<void> updateStudentDetails(
    Map<String, dynamic> studentInfo,
    String id,
  ) async {
    try {
      // 1. Target the specific document in the "Students" collection by 'id'
      // 2. Use .update() to apply the 'studentInfo' map changes
      await FirebaseFirestore.instance
          .collection('Students')
          .doc(id)
          .update(studentInfo);
    } catch (e) {
      print('Error updating student: $e');
    }
  }

  // TODO 4: Implement the DELETE operation
  Future<void> deleteStudent(String id) async {
    try {
      // 1. Target the specific document in the "Students" collection by 'id'
      // 2. Use .delete() to remove it from Firestore

      await FirebaseFirestore.instance.collection('Students').doc(id).delete();
    } catch (e) {
      print('Error deleting student: $e');
      rethrow;
    }
  }
}
